# Mapping of DEIMS-SDR entities provided in JSON moreover onto Environmental Monitoring Facility Vocabulary SmOD, Semantic Sensor Network (SSN), Sensor, Observation, Sample, Actuator (SOSA), Friends Of A Friends (FOAF), and Provenance (PROV-O) ontologies

Authors: Alessandro Oggioni [^1]
[^1]: alessandro.oggioni@cnr.it


## Dataset metadata elements mapping, based on "LTER Zöbelboden, Austria, Air chemistry, 2012" dataset (DEIMS.ID: https://deims.org/datasets/cd1fb6f8-5e57-11e3-aa73-005056ab003f). See also [JSON file for this dataset](dataset.json)

| **level** | **DEIMS-SDR site metadata element** | **JSON path (evaluated with Jayway JsonPath - https://sumiya.page)** | **JSON data item example** | **RDF rendering** | **notes** |
| --------- | ----------------------------------- | -------------------------------------------------------------------- | -------------------------- | ----------------- | --------- |
| 2	| id | concat( \$.id.prefix, \$.id.suffix) | `https://deims.org/dataset/cd1fb6f8-5e57-11e3-aa73-005056ab003f` | `<https://deims.org/dataset/cd1fb6f8-5e57-11e3-aa73-005056ab003f> rdf:type dcat:Dataset`	| Only the ID is used, as the RDF correspondence of the dataset is provided by DAR or B2Share |
