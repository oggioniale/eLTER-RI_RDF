#!/bin/bash
# ===================================================================
# pipeline.sh
# -------------------------------------------------------------------
# Author: Alessandro Oggioni <https://orcid.org/0000-0002-7997-219X>
# Date Created: 2025-05-04
# Description: 
#   This script automates the generation and publication of RDF Turtle 
#   (.ttl) files based on SPARQL-Generate queries. It retrieves data 
#   from the DEIMS-SDR (deims.org), processes monitoring sites and networks, 
#   and loads the resulting TTL files into a Fuseki triple store. 
#   The script performs the following steps:
#   1. Generates RDF data for sites and networks using SPARQL-Generate.
#   2. Daily, it fetches a list of sites from the DEIMS API, processes them
#      based on their modification date, removes outdated content, and 
#      reloads the updated RDF versions.
#   3. Daily, it compares the newly generated RDF data for networks with
#      the previously processed data using SHA256 checksums, and reloads 
#      only the modified content if changes are detected.
#
# License: Apache License 2.0
# 
# Copyright 2025 Alessandro Oggioni. All Rights Reserved.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied. See the License for the specific language governing
# permissions and limitations under the License.
#
# Usage: 
#   ./pipeline.sh -c CREDENTIALS -e ENDPOINT -w WEB_BASE_URL [-d DATASET]
#   -c CREDENTIALS     Fuseki credentials (e.g., 'username:password')
#   -e ENDPOINT        Fuseki endpoint URL (e.g., 'http://your-fuseki-server-url')
#   -d DATASET         Dataset name where data will be loaded (default: 'elter')
#   -w WEB_BASE_URL    Base URL of the published TTL files (e.g., 'http://example.com/elter')
# ===================================================================
set -euo pipefail

# Default values
DATASET="elter"
CREDENTIALS=""
ENDPOINT=""
WEB_BASE_URL=""

# Log files
log_file="query_run.log"
checksum_log="checksums.log"
: > "$log_file"
: > "$checksum_log"

# Logging function
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$log_file"
}

# Function to display help message
show_help() {
  echo "Usage: $0 -c CREDENTIALS -e ENDPOINT [-d DATASET] -w WEB_BASE_URL"
  echo
  echo "This Bash script automates the generation and publication of RDF Turtle (.ttl) files based on SPARQL-Generate queries."
  echo "It retrieves data from the DEIMS-SDR (deims.org), processes monitoring sites and networks, and loads the resulting TTL files into a Fuseki triple store."
  echo "The script performs the following steps:"
  echo  "1. Generates RDF data for sites and networks using SPARQL-Generate."
  echo  "2. Daily, it fetches a list of sites from the DEIMS API, processes them"
  echo  "   based on their modification date, removes outdated content, and"
  echo  "   reloads the updated RDF versions."
  echo  "3. Daily, it compares the newly generated RDF data for networks with"
  echo  "   the previously processed data using SHA256 checksums, and reloads"
  echo  "   only the modified content if changes are detected."
  echo
  echo "Options:"
  echo "  -c CREDENTIALS    Fuseki credentials (e.g., 'username:password')"
  echo "  -e ENDPOINT       Fuseki endpoint URL (e.g., 'http://your-fuseki-server-url'). Please remember to provide the URL without the trailing slash."
  echo "  -d DATASET        Dataset name where the data will be loaded (default: 'elter')"
  echo "  -w WEB_BASE_URL   Base URL of the published TTL files for Fuseki LOAD (e.g., 'http://10.0.0.58/elter')"
  echo "  -h                Show this help message and exit"
  exit 0
}

# Parse command line arguments
while getopts "c:e:d:w:h" opt; do
  case "$opt" in
    c) CREDENTIALS="$OPTARG" ;;
    e) ENDPOINT="$OPTARG" ;;
    d) DATASET="$OPTARG" ;;
    w) WEB_BASE_URL="$OPTARG" ;;
    h) show_help ;;
    *) echo "Invalid option: -$OPTARG" >&2; show_help; exit 1 ;;
  esac
done

if [[ -z "$CREDENTIALS" ]]; then
  echo "❌ Missing required -c CREDENTIALS" >&2
  exit 1
fi

if [[ -z "$ENDPOINT" ]]; then
  echo "❌ Missing required -e ENDPOINT" >&2
  exit 1
fi

if [[ -z "$WEB_BASE_URL" ]]; then
  echo "❌ Missing required -w WEB_BASE_URL" >&2
  exit 1
fi

# Define directories and paths
deims_queries_outputs="./deims_queries_outputs"  # o il percorso completo
web_dir="/var/www/html/elter"
query_dir="sparqlGenerateQueries"
template_file="$query_dir/siteSparqlGenerate.txt"

# Create site list
log "🌐 Fetching latest site list from DEIMS API..."
curl -s "https://deims.org/api/sites" | jq -r '.[] | "\(.title);\(.id.suffix);\(.changed)"' > sites_list_last.csv
log "✅ Site list successfully saved to sites_list_last.csv"

# Define paths
last_sites_list_file="sites_list_last.csv"
last_sites_ttl_file="/var/www/html/elter/sites.ttl"

# Get the timestamp of the last run from file, or default to 1970
timestamp_file="last_run_timestamp.txt"
if [[ -f "$timestamp_file" ]]; then
  last_run_timestamp=$(cat "$timestamp_file")
else
  last_run_timestamp="1970-01-01T00:00:00"
fi

log "📅 Last run timestamp from file: $last_run_timestamp"

# Filter the sites in sites_list_last.csv that have a timestamp more recent than the last sites.ttl
filtered_sites="sites_changed.csv"
> "$filtered_sites"  # Clear the filtered sites file

log "Filtering sites in $last_sites_list_file based on timestamp..."
while IFS=';' read -r title raw_uuid site_date; do
  # Assuming site_date is in format YYYY-MM-DD HH:MM:SS
  if [[ "$site_date" > "$last_run_timestamp" ]]; then
    echo "$title;$raw_uuid;$site_date" >> "$filtered_sites"
    log "✅ Site $title with UUID $raw_uuid is newer than the last sites.ttl"
  else
    log "❌ Site $title with UUID $raw_uuid is older than the last sites.ttl"
  fi
done < "$last_sites_list_file"

# Check if there are changes (i.e., if sites_changed.csv is not empty)
if [[ -s "$filtered_sites" ]]; then
  log "🟢 Changes detected in sites."
else
  log "🔴 No changes detected in sites."
  exit 0  # Exit if there are no changes (you can choose to proceed depending on your needs)
fi

log "Filtered sites are saved in $filtered_sites"

# Step 4: Process only the filtered sites (sites_changed.csv) using SPARQL Generate
# (This is where you can now use $filtered_sites as your input file instead of the entire sites_list_last.csv)
total_sites=$(wc -l < "$filtered_sites")
current_site=0

log "▶ Processing sites..."

# Initialize the TTL file
ttl_file_sites="./deims_queries_outputs/sites.ttl"
> "$ttl_file_sites"  # Pulisce il file sites.ttl se esiste già

# Start processing the sites in the sites_changed.csv file
while IFS=';' read -r title raw_uuid site_date; do
  current_site=$((current_site + 1))
  uuid=$(echo "$raw_uuid" | sed -E 's/^"//;s/"$//' | xargs)

  log "▶ [$current_site/$total_sites] Site: $title UUID: $uuid"

  temp_query=$(mktemp)
  sed "s|{ ?suffix }|$uuid|g" "$template_file" > "$temp_query"

  java -jar sparql-generate-2.0-SNAPSHOT.jar \
    -d "$query_dir" \
    -q "$temp_query" \
    -l ERROR > query.out 2>> "$log_file"

  tr -d '\000' < query.out >> "$ttl_file_sites"
  sed -i -e 's/< http/<http/g' -e 's/ >/>/g' "$ttl_file_sites"
  rm "$temp_query"

  log "✅ SPARQL query executed for $title"

  sed -i "s|$uuid|{ ?suffix }|g" "$template_file"
done < "$filtered_sites"

log "Filtered sites are saved in $filtered_sites"

# Check for file changes
declare -A status=()
names=("networks" "sites")

for name in "${names[@]}"; do
  ttl_file="$deims_queries_outputs/$name.ttl"
  sha_file="$ttl_file.sha256"

  if [[ -f "$ttl_file" ]]; then
    if [[ -f "$sha_file" ]]; then
      if sha256sum -c "$sha_file" --status >> "$checksum_log" 2>&1; then
        status["$name"]=0
        log "🟢 No changes detected in $name."
      else
        status["$name"]=1
        log "🟡 Changes detected in $name."
      fi
    else
      status["$name"]=1
      log "🆕 No previous checksum for $name."
    fi
    sha256sum "$ttl_file" > "$sha_file"
  else
    status["$name"]=2
    log "❌ Missing TTL file: $name"
  fi
done

# DEBUG: print statuses
log "🔎 DEBUG: status[networks]=${status[networks]:-N/A}, status[sites]=${status[sites]:-N/A}"

# Calculate a flag to check if any files have changed
flag=0
for name in "${names[@]}"; do
if [[ "${status[$name]}" -eq 1 ]]; then
  flag=1
fi
done
log "🔍 DEBUG: flag=$flag"

# Initialize the file to store extracted URIs
extracted_uris=$(mktemp)

# Extract URIs excluding those from the 'networks' section and log how many were found
grep -v 'ef:broader' "$ttl_file_sites" \
  | grep -oP '(https://deims.org/[^/" >]+(?:/[^" >]+)?|https://orcid.org/[^"]+|https://ror.org/[^"]+|https://cordis.europa.eu/project/id/[^"]+)' \
  | grep -v '^https://deims.org/networks/' >> "$extracted_uris"
  
echo "[INFO] Extracted URIs (excluding networks): $(wc -l < "$extracted_uris") → $extracted_uris"

extracted_uris_cleaned="${extracted_uris%.txt}_cleaned.txt"

tr ',;' '\n' < "$extracted_uris" \
  | sed 's/[<>[:space:]]//g' \
  | sed 's/\.$//' \
  | grep -E '^https?://' \
  | sort -u > "$extracted_uris_cleaned"

echo "[INFO] Cleaned URIs written to: $extracted_uris_cleaned"

# Verifica se ci sono URI estratti
if [[ -s "$extracted_uris_cleaned" ]]; then
  log "✅ Extracted URIs: $(wc -l < "$extracted_uris_cleaned")"
else
  log "❌ No relevant URIs found for $ttl_file_sites. Skipping LOAD."
  exit 1
fi

# If changes have been detected
if [[ $flag -eq 1 ]]; then
  log "🔁 Changes detected, updating Fuseki and web..."

  # Check if there are URIs to be deleted in the clean file
  if [[ -s "$extracted_uris_cleaned" ]]; then
    log "✅ Extracted URIs to delete+load: $(wc -l < "$extracted_uris_cleaned")"
  else
    log "❌ No relevant URIs found. Skipping Fuseki update."
    exit 1
  fi

  # DELETE all extracted URIs (triple-based)
  log "🗑️  Deleting triples for extracted URIs (one by one)..."
  
  # Loop over cleaned URIs and send a separate DELETE request for each
  while read -r uri; do
    [[ -z "$uri" ]] && continue
    
    # Create the SPARQL DELETE query
    delete_query=$(mktemp)
    echo "DELETE WHERE { <$uri> ?p ?o }" > "$delete_query"
    log "🚩 DELETE query for <$uri> stored in $delete_query"
    
    # Log DELETE query content
    log "🚩 DELETE query content:"
    cat "$delete_query" >> "$log_file"
  
    # Send the DELETE query to Fuseki
    response=$(curl -s -o /tmp/delete_response.log -w "%{http_code}" \
      -X POST \
      --data-urlencode "update@${delete_query}" \
      -H "Content-Type: application/x-www-form-urlencoded" \
      "$ENDPOINT/$DATASET/update" \
      --max-time 10 \
      -u "$CREDENTIALS")
  
    if [[ "$response" != "200" ]]; then
      log "❌ SPARQL DELETE failed for <$uri>. HTTP $response"
      cat /tmp/delete_response.log >> "$log_file"
      exit 1
    else
      log "✅ DELETE executed successfully for <$uri>"
    fi
  
  done < "$extracted_uris_cleaned"

  # COPY TTL to web dir and LOAD
  log "📥 Loading updated TTLs into Fuseki..."
  for name in "${names[@]}"; do
    ttl_file="$deims_queries_outputs/$name.ttl"
    target_file="$web_dir/$name.ttl"

    if [[ -f "$ttl_file" ]]; then
      cp "$ttl_file" "$target_file"

      # Load the file only once per site
      encoded_load="update=LOAD%20%3C$(printf '%s' "$WEB_BASE_URL/$name.ttl" | jq -sRr @uri)%3E"
      response=$(curl -s -w "%{http_code}" -o /tmp/load_response.log \
                 "$ENDPOINT/$DATASET/update" \
                 -u "$CREDENTIALS" \
                 --data "$encoded_load")
      
      if [[ "$response" != "200" ]]; then
        log "❌ SPARQL LOAD failed for $name.ttl. HTTP $response"
        cat /tmp/load_response.log >> "$log_file"
        exit 1
      else
        log "✅ Loaded graph from $WEB_BASE_URL/$name.ttl"
      fi
    fi
  done
else
  log "✅ No changes detected. Nothing to publish."
fi

# Cleanup of temporary files
log "🧹 Cleaning up temporary files..."

# List of temporary files to remove (add others if needed)
temp_files=(
  "$extracted_uris"                # File with extracted URIs
  "$extracted_uris_cleaned"       # File with cleaned URIs for DELETE
  "$filtered_sites"               # File with sites changed
  "$delete_query"                 # SPARQL DELETE query temp file
  /tmp/delete_response.log        # Temporary curl response for DELETE
  /tmp/load_response.log          # Temporary curl response for LOAD
)

# Remove each temporary file if it exists
for tmp_file in "${temp_files[@]}"; do
  if [[ -f "$tmp_file" ]]; then
    rm -f "$tmp_file"
    log "🗑️  Removed temporary file: $tmp_file"
  fi
done

log "✅ Cleanup completed."

date -u +"%Y-%m-%dT%H:%M:%S" > "$timestamp_file"
log "📝 Updated last_run_timestamp.txt with current timestamp."

log "🔚 End of script."
