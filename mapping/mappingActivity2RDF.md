# Mapping of DEIMS-SDR's activity entity provided in JSON moreover using Environmental Monitoring Facility Vocabulary [(SmOD)](https://www.w3.org/2015/03/inspire/ef), Dublin core terms [(DC)](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/), Data Catalog Vocabulary [(DCAT)](https://semiceu.github.io/DCAT-AP/releases/3.0.0/) and Provenance ontology [(PROV-O)](https://www.w3.org/TR/prov-o/).

Authors: Alessandro Oggioni [^1]
[^1]: alessandro.oggioni@cnr.it

Namespaces and prefixes used in this documentation:

| **Prefix** | **Namespace IRI** |
| ---------- | ----------------- |
| ef | http://www.w3.org/2015/03/inspire/ef# |
| prov | http://www.w3.org/ns/prov# |
| rdf | http://www.w3.org/1999/02/22-rdf-syntax-ns# |
| dcterm | http://purl.org/dc/terms/ |
| dcterms | http://purl.org/dc/terms/ |
| dcat | http://www.w3.org/ns/dcat# |
| geosparql | http://www.opengis.net/ont/geosparql# |
| locn | http://www.w3.org/ns/locn# |
| xsd | http://www.w3.org/2001/XMLSchema# |

## Activity metadata elements mapping, based on the “LTER Zöbelboden Austria deposition” activity (DEIMS.ID - https://deims.org/activity/4efaa2f2-6f4a-4f75-b95c-c3ffb13594a5). See also [JSON file for this activity](activity.json)

| **level** | **DEIMS-SDR site metadata element** | **JSON path (evaluated with Jayway JsonPath - https://sumiya.page)** | **JSON data item example** | **RDF rendering** | **notes** |
| --------- | ----------------------------------- | -------------------------------------------------------------------- | -------------------------- | ----------------- | --------- |
| 1	| title	| $.title	| `"LTER Zöbelboden Austria deposition"` | `ef:name "LTER Zöbelboden Austria deposition"@en` | | | 
| 2	| id | concat( \$.id.prefix, \$.id.suffix) | `"https://deims.org/activity/4efaa2f2-6f4a-4f75-b95c-c3ffb13594a5"` | `<https://deims.org/activity/4efaa2f2-6f4a-4f75-b95c-c3ffb13594a5> rdf:type prov:Activity , ef:EnvironmentalMonitoringActivity` | | | 
| 3	| type | $.type | `"activity"` | `ef:specialisedEMFType ‘activity’@en` | | | 
| 4	| created	| $.created	| `"2016-09-12T18:45:29+0200"` | `dcterms:issued "2016-09-12T18:45:29+0200"^^xsd:dateTime`	| | | 
| 5	| changed	| $.changed	| `"2019-08-20T13:13:04+0200"` | `dcterms:modified "2019-08-20T13:13:04+0200"^^xsd:dateTime` | | | 
| 6.1.1	| attributes.general.relatedSite | $.attributes.general.relatedSite[*].id.[?(@.suffix != null)].suffix	| `[{ "type": "site", "title": "LTER Zöbelboden - Austria", "id": { "prefix": "https://deims.org/", "suffix": "8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6" }, "changed": "2025-01-07T11:14:56+0100" }]`	| - | not included | 
| 6.1.2	| attributes.general.abstract	| $.attributes.general.abstract	| `"Deposition data from LTER Zöbelboden. The data comprises … "`	| `dcterms:description  "Deposition data from LTER Zöbelboden. The data comprises … "` | | | 
| 6.1.3	| attributes.general.keywords	| $.attributes.general.keywords[*].label | `[ "Base cations deposition", … ]`	| `dcat:keyword "Base cations deposition"@en , …`	| | | 
| 6.1.4	| attributes.general.dateRange | $.attributes.general.dateRange.from | `"1993-01-01"` | `prov:startedAtTime "1993-01-01"^^xsd:dateTime`	| | | 
| | | $.attributes.general.dateRange.to	| `"2015-12-31"` | `prov:endedAtTime "2015-12-31"^^xsd:dateTime` | | | 
| 6.2.1	| attributes.contact.corresponding | $.attributes.contact.corresponding[*].[?(@.type == 'person')].[?(@.orcid != null)] | `[{ "type": "person", "name": "Johannes Kobler", "email": "johannes.kobler@umweltbundesamt.at", "orcid": "https://orcid.org/0000-0003-0052-4245" },{ "type": "person", "name": "Thomas Dirnboeck", "email": "thomas.dirnboeck@umweltbundesamt.at", "orcid": "https://orcid.org/0000-0002-8294-0690" }]` | `dcat:contactPoint <https://orcid.org/0000-0003-0052-4245>` | iterating over each of the obtained site manager |
| | | | | `<https://orcid.org/0000-0003-0052-4245> rdf:type prov:Agent , foaf:Person; foaf:fullName  "Johannes Kobler"; foaf:hasEmail <mailto: johannes.kobler@umweltbundesamt.at>` | with the aim of creating a new node for the site manager graph. Iterating over each of the obtained site manager. |
| 6.2.2	| attributes.contact.metadataProvider	| `$.attributes.contact.metadataProvider[*].[?(@.type == 'person')].[?(@.orcid != null)]`	| `[{ "type": "person", "name": "Johannes Kobler", "email": "johannes.kobler@umweltbundesamt.at", "orcid": "https://orcid.org/0000-0003-0052-4245" },{ "type": "person", "name": "Thomas Dirnboeck", "email": "thomas.dirnboeck@umweltbundesamt.at", "orcid": "https://orcid.org/0000-0002-8294-0690" }]` | -	| the property for link metadata provider with site is not yet identified |
| | | | | `<https://orcid.org/0000-0003-0052-4245> rdf:type prov:Agent , foaf:Person; foaf:fullName "Johannes Kobler"; foaf:hasEmail <mailto:johannes.kobler@umweltbundesamt.at> , …`	| with the aim of creating a new node for the site manager graph. Iterating over each of the obtained site manager. |
| 6.3.1	| attributes.geographic.boundaries | $.attributes.geographic.boundaries | `"POLYGON ((14.435456610419 47.83985714374, 14.435472337769 …, ))"`	| `dcterms:spatial [ rdf:type dcterms:Location; locn:geometry  "<http://www.opengis.net/def/crs/EPSG/0/4326> POLYGON ((14.435456610419 47.83985714374, 14.435472337769 … , ]` | | | 
| 6.4	| attributes.availability	| $.attributes.availability	| `{ "digitally": true, "forEcopotential": true, "openData": true, "notes": "DEIMS data sets", "source": { "url": null } }`	| -	| not included | 
| 6.5.1	| attributes.observation | $.attributes.observation | `{ "parameters": [{ "label": "atmospheric parameter", "uri": "http://vocabs.lter-europe.net/EnvThes/20937" }, … ]}`	| `ef:observedProperty  <http://vocabs.lter-europe.net/EnvThes/20937> , …` | | | 
| 6.6	| attributes.resolution	| $.attributes.resolution	| `{ "spatial": null, "temporal": { "label": "weekly", "uri": null }}`	| -	| not yet included | 
| 6.7	| attributes.relatedResources	| $.attributes[?(@.relatedResources != null)].relatedResources[?(@.id.prefix=='https://deims.org/dataset/')].id[?(@.suffix != null)].suffix	| `[{ "id": { "prefix": "https://deims.org/dataset/", "suffix": "bf4bdb26-5387-11e4-a597-005056ab003f" }, "title": "LTER Zöbelboden, Austria, Throughfall chemistry, 1993-2012", "changed": "2023-07-13T09:41:57+0200" }]`	| `ef:hasObservation <https://deims.org/dataset/bf4bdb26-5387-11e4-a597-005056ab003f>` | | | 
| | | $.attributes[?(@.relatedResources != null)].relatedResources[?(@.id.prefix=='https://deims.org/sensor/')].id[?(@.suffix != null)].suffix | `null` | `ef:uses` | | |
