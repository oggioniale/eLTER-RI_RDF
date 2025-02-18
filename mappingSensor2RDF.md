# Mapping of DEIMS-SDR's activity entity provided in JSON moreover using Environmental Monitoring Facility Vocabulary [(SmOD)](https://www.w3.org/2015/03/inspire/ef), Dublin core terms [(DC)](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/), Semantic Sensor Network ontology [(SSN)](https://w3c.github.io/sdw-sosa-ssn/ssn/) and Sensor, Observation, Sample, and Actuator [(SOSA)](https://w3c.github.io/sdw-sosa-ssn/ssn/), Data Catalog Vocabulary [(DCAT)](https://semiceu.github.io/DCAT-AP/releases/3.0.0/) and Provenance ontology [(PROV-O)](https://www.w3.org/TR/prov-o/).

Authors: Alessandro Oggioni [^1]
[^1]: alessandro.oggioni@cnr.it

Namespaces and prefixes used in this documentation:

| **Prefix** | **Namespace IRI** |
| ---------- | ----------------- |
| ef | http://www.w3.org/2015/03/inspire/ef# |
| prov | http://www.w3.org/ns/prov# |
| rdf | http://www.w3.org/1999/02/22-rdf-syntax-ns# |
| rdfs | http://www.w3.org/2000/01/rdf-schema# |
| dcterm | http://purl.org/dc/terms/ |
| dcterms | http://purl.org/dc/terms/ |
| dcat | http://www.w3.org/ns/dcat# |
| geosparql | http://www.opengis.net/ont/geosparql# |
| geo | http://www.opengis.net/ont/geosparql# |
| xsd | http://www.w3.org/2001/XMLSchema# |

# Sensor metadata elements mapping, based on “LTER Zöbelboden Austria precipitation WW” sensor (DEIMS.ID - https://deims.org/sensors/fb583610-fe71-4793-b1a9-43097ed5c3e3). See also [JSON file for this sensor](sensor.json)

| **level** | **DEIMS-SDR site metadata element** | **JSON path (evaluated with Jayway JsonPath - https://sumiya.page)** | **JSON data item example** | **RDF rendering** | **notes** |
| --------- | ----------------------------------- | -------------------------------------------------------------------- | -------------------------- | ----------------- | --------- |
| 1	| title | $.title | `"LTER Zöbelboden Austria precipitation WW"` | `ef:name "LTER Zöbelboden Austria precipitation WW"@en` | | 
| 2 | id | concat( \$.id.prefix, \$.id.suffix) | `"https://deims.org/sensors/fb583610-fe71-4793-b1a9-43097ed5c3e3"` | `<https://deims.org/sensors/fb583610-fe71-4793-b1a9-43097ed5c3e3> rdf:type prov:Entity , sosa:Sensor , ssn:System` | | |	
| 3	| type | $.type | `"sensor"` | - | not included | 
| 4	| created	| $.created	| `"2017-02-14T21:40:40+0100"` | `dcterms:issued "2017-02-14T21:40:40+0100"^^xsd:dateTime` | | | 
| 5	| changed	| $.changed	| `"2019-11-29T11:33:23+0100"` | `dcterms:modified "2019-11-29T11:33:23+0100"^^xsd:dateTime` | | | 
| 6.1.1	| attributes.general.relatedSite | $.attributes.general.relatedSite[*].id.[?(@.suffix != null)].suffix	| `[ "8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6" ]`	| `sosa:isHostedBy <https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6>` | | | 	
| 6.1.2 | attributes.general.contact | $.attributes.general.contact[*].[?(@.type == 'person')].[?(@.orcid != null)] | `[{ "type": "person", "name": "Thomas Dirnboeck", "email": "thomas.dirnboeck@umweltbundesamt.at", "orcid": "https://orcid.org/0000-0002-8294-0690" }]`	| `dcat:contactPoint <https://orcid.org/0000-0002-8294-0690>`	| iterating over each of the obtained site manager |
| | | | | `<https://orcid.org/0000-0002-8294-0690> rdf:type prov:Agent , foaf:Person; foaf:fullName "Thomas Dirnboeck"; foaf:hasEmail  <mailto:thomas.dirnboeck@umweltbundesamt.at >` | with the aim of creating a new node for the site manager graph. Iterating over each of the obtained site manager. | 
| 6.1.3	| attributes.general.abstract	| $.attributes.general.abstract	| `"Precipitation measurement at LTER Zöbelboden …"` | `dcterms:description "Precipitation measurement at LTER Zöbelboden …"`	| | 
| 6.1.4	| attributes.general.dataRange | $.attributes.general.dateRange.from | `"1995-01-01"` | `prov:startedAtTime "1995-01-01"^^xsd:date`	| | 
| | | $.attributes.general.dateRange.to	| `null` | `prov:startedAtTime ""^^xsd:date`	| | | 
| 6.1.5	| attributes.general.keywords	| $.attributes.general.keywords[*].label | `[ "precipitation" ]` | `dcat:keyword "precipitation"@en`	| | |
| 6.2.1	| attributes.geographic.coordinates	| $.attributes.geographic.coordinates	| `"POINT (14.442 47.842)"`	| `dcterms:spatial [ rdf:type dcterms:Location; dcat:centroid  "<http://www.opengis.net/def/crs/EPSG/0/4326> POINT (14.442 47.842)"^^geosparql:wktLiteral ]`	|  |
| 6.2.2	| attributes.geographic.trajectory | $.attributes.geographic.trajectory	| `null` | - | not yet included | 
| 6.2.3	| attributes.geographic.elevation	| $.attributes.geographic.elevation.value	| `893`	| `geo:alt 893`	| |
| 6.3.1	| attributes.observation.sensorType	| $.attributes.observation.sensorType.label	| `"precipitation sensor"` | - | not included |
| 6.3.2	| attributes.observation.resultAcquisitionSource | $.attributes.observation.resultAcquisitionSource	| `"in-situ"` | - | not included |
| 6.3.3	| attributes.observation.observedProperty	| $.attributes.observation.observedProperty	| `null` | - | not included |
