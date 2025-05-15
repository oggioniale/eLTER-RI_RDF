# DEIMS-SDR to RDF

## Aim of the work
The goal is to generate an RDF-formatted copy of the shared entities from DEIMS-SDR (Dynamic Ecological Information Management System – Site and Dataset Registry) to facilitate the creation of a knowledge graph. This work draws inspiration from and builds upon the efforts initially undertaken in [![](https://img.shields.io/badge/doi-10.5281/zenodo.7313046-yellow.svg)](https://doi.org/10.5281/zenodo.7313046).

## Approach
In this work, actional mapping trougth the SPARQL GENERATE query language is employed to generate RDF data from the DEIMS-SDR API (figure 1), thanks to the mapping among resources' metadata elements and ontology properties (see bullet list below).
SPARQL GENERATE enables the creation of RDF data directly from SPARQL queries and is supported by the SPARQL-generate engine[^1], which is accessible as a web service at https://ci.mines-stetienne.fr/sparql-generate/.
[^1]: Maxime Lefrançois, Antoine Zimmermann, Noorani Bakerally A SPARQL extension for generating RDF from heterogeneous formats, In Proc. Extended Semantic Web Conference, ESWC, May 2017, Portoroz, Slovenia. [PDF](http://www.maxime-lefrancois.info/docs/LefrancoisZimmermannBakerally-ESWC2017-Generate.pdf)

SPARQL-Generate is a powerful template-based language designed for generating RDF or text streams from RDF datasets and documents in various formats (e.g., JSON, CSV, TXT). Built on SPARQL, it extends its functionality with advanced capabilities for template-based querying, transformation, and serialization.

As a W3C member submission, SPARQL-Generate is currently under review by the W3C RDF Data Shapes Working Group.

![diagramSteps](https://github.com/user-attachments/assets/9dafd85f-7c18-4062-82e0-5b9aad788c17 "The main steps to obtain the corresponding RDF files are represented here. In the diagram at the bottom left, the various resources shared through DEIMS-SDR are shown, here the arrows represent the existing relationships as rendered in the resulting graphs, while the orange labels, near to the resource icons, indicate the ontology or vocabulary used.")
Figure 1 - The main steps to obtain the corresponding RDF files are represented here. In the diagram at the bottom left, the various resources shared through DEIMS-SDR are shown, here the arrows represent the existing relationships as rendered in the resulting graphs, while the orange labels, near to the resource icons, indicate the ontology or vocabulary used.


## How is work organized?
By leveraging the SPARQL-Generate engine, it was possible to generate graphs for both sites and networks. Specifically, for a site, the engine enables the creation of all related resources—including datasets, sensors, activities, locations, people, organizations, and projects — also capturing the relationships between them.

### In the case of a **DEIMS-SDR site**
The work can be reproduced following this two files:

1. [`siteSparqlGenerate.txt`](./sparqlGenerateQueries/siteSparqlGenerate.txt) contains the SPARQL-Generate code to generate RDF for all site available in the DEIMS-API sites list (https://deims.org/api/sites), including its relationships with other resources such as: dataset(s), sensor(s), activitie(s), location(s), people, organization(s), and project(s);

2. [`siteRDF.ttl`](./examples/siteRDF.ttl) contains the result of the SPARQL-Generate query for the site "LTER Zöbelboden" (DEIMS.ID - [https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6](https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6)) and related resources such as:
- [LTER Zöbelboden, Austria, Project area](https://deims.org/api/locations/12b38f3f-7e72-425a-80c7-7cad35ce4c7b) (location),
- [LTER Zöbelboden Austria deposition](https://deims.org/api/activities/4efaa2f2-6f4a-4f75-b95c-c3ffb13594a5) (activity),
- [LTER Zöbelboden, Austria, Air chemistry, 2012](https://deims.org/api/datasets/cd1fb6f8-5e57-11e3-aa73-005056ab003f) (dataset),
- [LTER Zöbelboden Austria precipitation WW](https://deims.org/api/sensors/fb583610-fe71-4793-b1a9-43097ed5c3e3) (sensor),
- [Thomas Dirnboeck](https://orcid.org/0000-0002-8294-0690) (contact point),
- [Environment Agency Austria (EAA)](https://ror.org/013vyke20) (organization),
- [e-shape (H2020)](https://cordis.europa.eu/project/id/820852) (project).

Currently, the query is designed to generate RDF data for all the sites listed in the DEIMS-API sites list (https://deims.org/api/sites) as of 30.04.2025.

To reproduce the example for Zöbelboden, you can use the file [`siteSparqlGenerate_Zobelboden.txt`](./sparqlGenerateQueries/siteSparqlgenerate_Zobelboden.txt) and execute the following command:

`java -jar sparql-generate-2.0-SNAPSHOT.jar -d sparqlGenerateQueries -q ./sparqlGenerateQueries/siteSparqlGenerate_Zobelboden.txt -f sites.log -l DEBUG`

This command will generate the RDF for the site "LTER Zöbelboden" (DEIMS.ID - https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6) and its associated resources.

### In the case of a **DEIMS-SDR network**
The work can be reproduced following this two files:

1. [`networkSparqlGenerate.txt`](./sparqlGenerateQueries/networkSparqlGenerate.txt) contains the SPARQL-Generate code to generate RDF for a network, including its relationships with other networks;

2. [`networkRDF.ttl`](./examples/networkRDF.ttl) contains the result of the SPARQL-Generate query for the network "LTER Europe" (DEIMS.ID - [https://deims.org/networks/4742ffca-65ac-4aae-815f-83738500a1fc](https://deims.org/networks/4742ffca-65ac-4aae-815f-83738500a1fc)).

Currently, the query is designed to collect information from the “LTER Europe” network (DEIMS.ID - https://deims.org/networks/4742ffca-65ac-4aae-815f-83738500a1fc), which, as of 30.01.2025, is record 55 in the list of sites here: https://deims.org/api/networks.

Change line 42 of the [`networkSparqlGenerate.txt`](./sparqlGenerateQueries/networkSparqlGenerate.txt) file for execute this query for other network. Change the value in "$[:10]" to execute the query only for the first ten items in the list of sites (https://deims.org/api/networks).

### Reproduce the result
To reproduce the results Simply copy the content of the [`siteSparqlGenerate.txt`](./sparqlGenerateQueries/siteSparqlGenerate.txt) or [`networkSparqlGenerate.txt`](./sparqlGenerateQueries/networkSparqlGenerate.txt) file into the playground on the http://sparql-generate.org/ website and click "Run".
The output will be an RDF file in Turtle format, which can be saved with a `.ttl` extension.

### Mapping of API metadata elements to ontology and vocabulary properties
To explore the mapping of API metadata elements to various ontology and vocabulary properties across different DEIMS-SDR resources, refer to the following files:

- [`mappingSite2RDF.md`](mappingSite2RDF.md) for sites;

- [`mappingNetwork2RDF.md`](./mapping/mappingNetwork2RDF.md) for networks;

- [`mappingActivity2RDF.md`](./mapping/mappingActivity2RDF.md) for activities;

- [`mappingDataset2RDF.md`](./mapping/mappingDataset2RDF.md) for datasets;

- [`mappingLocation2RDF.md`](./mapping/mappingLocation2RDF.md) for locations;

- [`mappingSensor2RDF.md`](./mapping/mappingSensor2RDF.md) for sensors.

### Examples of JSON files from the DEIMS-SDR APIs
This repository also includes JSON files, as examples, from the DEIMS-SDR APIs for the various mapped resources:

- [`site.json`](./examples/site.json) for site, if you need to view the original version of this resource, please visit this [page](https://deims.org/api/sites/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6);

- [`network.json`](./examples/network.json) for network, if you need to view the original version of this resource, please visit this [page](https://deims.org/api/networks/4742ffca-65ac-4aae-815f-83738500a1fc);

- [`activity.json`](./examples/activity.json) for activity, if you need to view the original version of this resource, please visit this [page](https://deims.org/api/activities/4efaa2f2-6f4a-4f75-b95c-c3ffb13594a5);

- [`dataset.json`](./examples/dataset.json) for dataset, if you need to view the original version of this resource, please visit this [page](https://deims.org/api/datasets/cd1fb6f8-5e57-11e3-aa73-005056ab003f);

- [`location.json`](./examples/location.json) for location, if you need to view the original version of this resource, please visit this [page](https://deims.org/api/locations/12b38f3f-7e72-425a-80c7-7cad35ce4c7b);

- [`sensor.json`](./examples/sensor.json) for sensor, if you need to view the original version of this resource, please visit this [page](https://deims.org/api/sensors/fb583610-fe71-4793-b1a9-43097ed5c3e3).

--------------------

## Pipeline Script for RDF Turtle Generation and Publishing: pipeline.sh

### Description:
This script automates the generation and publication of RDF Turtle (.ttl) files based on SPARQL-Generate queries. It retrieves data from the DEIMS-SDR 
([deims.org](https://deims.org)), processes monitoring sites and networks, and loads the resulting TTL files into a Fuseki triple store. 
The script performs the following steps:

1. Generates RDF data for sites and networks using SPARQL-Generate.
2. Daily, it fetches a list of sites from the DEIMS API, processes them based on their modification date, removes outdated content, and 
reloads the updated RDF versions.
3. Daily, it compares the newly generated RDF data for networks with the previously processed data using SHA256 checksums, and reloads 
only the modified content if changes are detected.

### Usage:
```bash
./pipeline.sh -c CREDENTIALS -e ENDPOINT -w WEB_BASE_URL [-d DATASET]
```

### Options:
-c CREDENTIALS: Fuseki credentials (e.g., 'username:password')

-e ENDPOINT: Fuseki endpoint URL (e.g., 'http://your-fuseki-server-url'). Please remember to provide the URL without the trailing slash.

-d DATASET: Dataset name where the data will be loaded (default: 'elter')

-w WEB_BASE_URL: Base URL of the published TTL files for Fuseki LOAD (e.g., 'http://example.com/elter')

-h: Show this help message and exit

### Example:
```
./pipeline.sh -c 'admin:password' -e 'http://localhost:3030' -w 'http://example.com/elter'
```

### Dependencies:
- [SPARQL-Generate](https://github.com/sparql-generate)
- [jq](https://jqlang.org)

### Additional Notes:
Ensure the necessary credentials for Fuseki and web server access are provided.
The dataset will be loaded into Fuseki only if new data is detected, avoiding redundant uploads.


## Acknowledgements
This work has been partially funded from the European Union's Horizon 2020 and Horizon Europe research and innovation programmes under the [H2020 eLTER-Plus Project](https://elter-ri.eu/elter-plus) grant agreement Nr. 871128 and [eLTER EnRich Project](https://elter-ri.eu/elter-enrich) grant agreement Nr. 101131751.
