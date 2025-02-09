# Mapping of DEIMS-SDR entities provided in JSON moreover onto Environmental Monitoring Facility Vocabulary SmOD, Semantic Sensor Network (SSN), Sensor, Observation, Sample, Actuator (SOSA), Friends Of A Friends (FOAF), and Provenance (PROV-O) ontologies

Authors: Alessandro Oggioni [^1]
[^1]: alessandro.oggioni@cnr.it


## Location metadata elements mapping, based on LTER Zöbelboden, Austria, Project area (DEIMS.ID - https://deims.org/locations/12b38f3f-7e72-425a-80c7-7cad35ce4c7b). See also [JSON file for this location](location.json)

| **level** | **DEIMS-SDR site metadata element** | **JSON path (evaluated with Jayway JsonPath - https://sumiya.page)** | **JSON data item example** | **RDF rendering** | **notes** |
| --------- | ----------------------------------- | -------------------------------------------------------------------- | -------------------------- | ----------------- | --------- |
| 1	| type | $.type | `"Feature"`	| -	| not included | 
| 2	| geometry	| $.geometry	| `{ "type": "Polygon", "coordinates": [[[ 14.435456610495, 47.839857143486 ], [ 14.435472337877, … ], … ]]}`	| -	| not yet included because the JSON result is not a WKT | 
| 3.1	| properties.title | $.properties.title	| `"LTER Zöbelboden, Austria, Project area"` | `ef:name "LTER Zöbelboden, Austria, Project area"@en` | | 
| 3.2	| properties.id	| concat( \$.properties.id.prefix, \$.properties.id.suffix) | `"https://deims.org/locations/12b38f3f-7e72-425a-80c7-7cad35ce4c7b"`	| `<https://deims.org/locations/12b38f3f-7e72-425a-80c7-7cad35ce4c7b> rdf:type prov:Entity , ef:EnvironmentalMonitoringFacility` | | 
| 3.3	| properties.created | $.properties.created	| `"2017-04-06T09:36:06+0200"` | `dcterms:issued "2017-04-06T09:36:06+0200"^^xsd:dateTime` | | 
| 3.4	| properties.changed | $.properties.changed	| `"2024-05-07T14:22:05+0200"` | `dcterms:modified "2024-05-07T14:22:05+0200"^^xsd:dateTime` | | 
| 3.4	| properties.locationType	| $.properties.locationType	| `{ "label": "Sampling Location", "uri": "http://vocabs.lter-europe.net/elter_cl/10494" }`	| `ef:specialisedEMFType <http://vocabs.lter-europe.net/elter_cl/10494>`	| | 
| 3.5	| properties.relatedSite | $.properties.relatedSite.id.[?(@.suffix != null)].suffix | `[ "8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6" ]`	| `ef:belongsTo <https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6>`	| | 
| 3.6	| properties.abstract	| $.properties.abstract	| `"Bounding Box for the LTER Station Zöbelboden"`	| `dcterms:description "Bounding Box for the LTER Station Zöbelboden"@en`	| | 
| 3.7	| properties.size	| $.properties.size	| `{ "value": 88.45, "unit": "ha" }`	| -	| not included | 
| 3.8	| properties.elevation | $.properties.elevation | `{ "min": 440, "max": 957, "unit": "msl" }`	| -	| not included |
| 3.9	| properties.images	| $.properties.images	| `null` | - | not included |