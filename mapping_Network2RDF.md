# Mapping DEIMS-SDR network JSON onto Environmental Monitoring Facility Vocabulary SmOD.

Authors: Alessandro Oggioni [^1]
[^1]: alessandro.oggioni@cnr.it


## Mapping based on the network <https://deims.org/networks/7fef6b73-e5cb-4cd2-b438-ed32eb1504b3>

| **level** | **DEIMS-SDR site metadata element** | **JSON path (evaluated with Jayway JsonPath - https://sumiya.page)** | **JSON data item example** | **RDF rendering** | **notes** |
| --------- | ----------------------------------- | -------------------------------------------------------------------- | -------------------------- | ----------------- | --------- |
| 1	| title	| $.title	| `"LTER Europe"`	| `ef:name "LTER Europe"` | | | 	
| 2	| id	| concat( $.id.prefix, $.id.suffix)	| `"https://deims.org/networks/4742ffca-65ac-4aae-815f-83738500a1fc"`	| `<https://deims.org/networks/4742ffca-65ac-4aae-815f-83738500a1fc> rdf:type ef:EnvironmentalMonitoringNetwork` | | | 
| 3	| type | $.type | `"network"` | `ef:specialisedEMFType "network"@en` | | | 
| 4	| created	| $.created	| `"2020-03-02T13:11:00+0100"` | `dcterms:issued "2020-03-02T13:11:00+0100"^^xsd:dateTime` | | | 	
| 5	| changed	| $.changed	| `"2023-02-17T12:48:37+0100"` | `dcterms:modified "2023-02-17T12:48:37+0100"^^xsd:dateTime` | | | 	
| 6.1	| attributes.abstract	| $.attributes.abstract	| `"Long-Term Ecosystem Research (LTER) is an essential component … "`	| `dcterms:description "Long-Term Ecosystem Research (LTER) is an essential component … "` | | | 
| 6.2	| attributes.url | $.attributes.url	| `[ "https://elter-ri.eu/" ]`	| -	| not included | 
| 6.3	| attributes.logo	| $.attributes.logo	| `[{ "url": "https://deims.org/sites/default/files/2020-10/elter%20logo_2.png", "alt": "LTER Europe Logo" }]`	| -	| not included | 
| 6.4	| attributes.belongsTo | $.attributes.belongsTo | `[{ "type": "network", "title": "GERI", "id": { "prefix": "https://deims.org/networks/", "suffix": "c3abdc60-49f1-49db-81fe-863b7dbb21d3" }}, … ]`	| | | 	
| 6.5	| attributes.consistsOf	| $.attributes.consistsOf	| `[{ "type": "network", "title": "CZ-LTER", "id": { "prefix": "https://deims.org/networks/", "suffix": "0a5cf43b-2e31-4348-803c-e45f2ff7d27a" }}, … }` | | | 		
| 6.6	| attributes.verifiedMemberSites	| $.attributes.verifiedMemberSites	| `{ "title": "API call for listing all verified member sites of the network", "href": "https://deims.org/api/sites?network=4742ffca-65ac-4aae-815f-83738500a1fc&verified=true", "type": "application/json" }` | -	| not included | 
| 6.7	| attributes.unverifiedMemberSites	| $.attributes.unverifiedMemberSites	| `{ "title": "API call for listing all unverified sites claiming to be part of the network", "href": "https://deims.org/api/sites?network=4742ffca-65ac-4aae-815f-83738500a1fc&verified=false", "type": "application/json" }` | -	| not included | 
