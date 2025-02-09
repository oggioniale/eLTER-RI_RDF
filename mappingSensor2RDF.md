# Mapping of DEIMS-SDR entities provided in JSON moreover onto Environmental Monitoring Facility Vocabulary SmOD, Semantic Sensor Network (SSN), Sensor, Observation, Sample, Actuator (SOSA), Friends Of A Friends (FOAF), and Provenance (PROV-O) ontologies

Authors: Alessandro Oggioni [^1]
[^1]: alessandro.oggioni@cnr.it


# Sensor metadata elements mapping, based on “LTER Zöbelboden Austria precipitation WW” sensor (DEIMS.ID - https://deims.org/sensors/fb583610-fe71-4793-b1a9-43097ed5c3e3). See also [JSON file for this sensor](sensor.json)

| **level** | **DEIMS-SDR site metadata element** | **JSON path (evaluated with Jayway JsonPath - https://sumiya.page)** | **JSON data item example** | **RDF rendering** | **notes** |
| --------- | ----------------------------------- | -------------------------------------------------------------------- | -------------------------- | ----------------- | --------- |
| 1	| title | $.title | `"LTER Zöbelboden Austria precipitation WW"` | `ef:name "LTER Zöbelboden Austria precipitation WW"@en` | | 
| 2 | id | concat( \$.id.prefix, \$.id.suffix) | `"https://deims.org/sensors/fb583610-fe71-4793-b1a9-43097ed5c3e3"` | `<https://deims.org/sensors/fb583610-fe71-4793-b1a9-43097ed5c3e3> rdf:type prov:Entity , sosa:Sensor , ssn:System` | | |	
| 3	| type | $.type | `"sensor"` | - | not included | 
| 4	| created	| $.created	| `"2017-02-14T21:40:40+0100"` | `dcterms:issued "2017-02-14T21:40:40+0100"^^xsd:dateTime` | | | 
| 5	| changed	| $.changed	| `"2019-11-29T11:33:23+0100"` | `dcterms:modified "2019-11-29T11:33:23+0100"^^xsd:dateTime` | | | 
| 6.1.1	| attributes.general.relatedSite | $.attributes.general.relatedSite[*].id.[?(@.suffix != null)].suffix	| `[ "8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6" ]`	| `sosa:isHostedBy <https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6>` | | | 	
| 6.1.2	| attributes.general.contact | $.attributes.general.contact	| `[{ "type": "organisation", "name": "Environment Agency Austria (EAA)", "url": "http://www.umweltbundesamt.at/", "ror": "https://ror.org/013vyke20" }, … ]`	| -	| not included | 
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
