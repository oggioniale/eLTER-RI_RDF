# Mapping of DEIMS-SDR's dataset entity provided in JSON using Data Catalog Vocabulary [(DCAT)](https://semiceu.github.io/DCAT-AP/releases/3.0.0/).

Authors: Alessandro Oggioni [^1]
[^1]: alessandro.oggioni@cnr.it

Namespaces and prefixes used in this documentation:

| **Prefix** | **Namespace IRI** |
| ---------- | ----------------- |
| rdf | http://www.w3.org/1999/02/22-rdf-syntax-ns# |
| dcat | http://www.w3.org/ns/dcat# |

## Dataset metadata elements mapping, based on "LTER Zöbelboden, Austria, Air chemistry, 2012" dataset (DEIMS.ID: https://deims.org/datasets/cd1fb6f8-5e57-11e3-aa73-005056ab003f). See also [JSON file for this dataset](dataset.json)

| **level** | **DEIMS-SDR site metadata element** | **JSON path (evaluated with Jayway JsonPath - https://sumiya.page)** | **JSON data item example** | **RDF rendering** | **notes** |
| --------- | ----------------------------------- | -------------------------------------------------------------------- | -------------------------- | ----------------- | --------- |
| 2	| id | concat( \$.id.prefix, \$.id.suffix) | `https://deims.org/dataset/cd1fb6f8-5e57-11e3-aa73-005056ab003f` | `<https://deims.org/dataset/cd1fb6f8-5e57-11e3-aa73-005056ab003f> rdf:type dcat:Dataset`	| Only the ID is used, as the RDF correspondence of the dataset is provided by DAR or B2Share |
