# DEIMS-SDR to RDF

## Aim of the work
The goal is to generate an RDF-formatted copy of the shared entities from DEIMS-SDR (Dynamic Ecological Information Management System – Site and Dataset Registry) to facilitate the creation of a knowledge graph. This work draws inspiration from and builds upon the efforts initially undertaken in [![](https://img.shields.io/badge/doi-10.5281/zenodo.7313046-yellow.svg)](https://doi.org/10.5281/zenodo.7313046).

## Approach
In this work, actional mapping trougth the SPARQL GENERATE query language is employed to generate RDF data from the DEIMS-SDR API (figure 1), thanks to the mapping among resources' metadata elements and ontology properties.
SPARQL GENERATE enables the creation of RDF data directly from SPARQL queries and is supported by the SPARQL-generate engine[^1], which is accessible as a web service at http://sparql-generate.org/.
[^1]: Maxime Lefrançois, Antoine Zimmermann, Noorani Bakerally A SPARQL extension for generating RDF from heterogeneous formats, In Proc. Extended Semantic Web Conference, ESWC, May 2017, Portoroz, Slovenia. [PDF](http://www.maxime-lefrancois.info/docs/LefrancoisZimmermannBakerally-ESWC2017-Generate.pdf)

SPARQL-Generate is a powerful template-based language designed for generating RDF or text streams from RDF datasets and documents in various formats (e.g., JSON, CSV, TXT). Built on SPARQL, it extends its functionality with advanced capabilities for template-based querying, transformation, and serialization.

As a W3C member submission, SPARQL-Generate is currently under review by the W3C RDF Data Shapes Working Group.

![diagramSteps](https://github.com/user-attachments/assets/9dafd85f-7c18-4062-82e0-5b9aad788c17 "The main steps to obtain the corresponding RDF files are represented here. In the diagram at the bottom left, the various resources shared through DEIMS-SDR are shown, here the arrows represent the existing relationships as rendered in the resulting graphs, while the orange labels, near to the resource icons, indicate the ontology or vocabulary used.")
Figure 1 - The main steps to obtain the corresponding RDF files are represented here. In the diagram at the bottom left, the various resources shared through DEIMS-SDR are shown, here the arrows represent the existing relationships as rendered in the resulting graphs, while the orange labels, near to the resource icons, indicate the ontology or vocabulary used.


## How is work organized?
By leveraging the SPARQL-Generate engine, it was possible to generate graphs for both sites and networks. Specifically, for a site, the engine enables the creation of all related resources—including datasets, sensors, activities, locations, people, organizations, and projects—while also capturing the relationships between them.

In the case of a **DEIMS-SDR site**, the work can be reproduced following this two files:
- [`siteSparqlGenerate.txt`](siteSparqlGenerate.txt) contains the SPARQL-Generate code to generate RDF for a site, dataset(s), sensor(s), activities, locations, people, organizations, and projects, including the relationships between these resources;

- [`siteRDF.ttl`](siteRDF.ttl) contains the result of the SPARQL-Generate query for the site "LTER Zöbelboden" (DEIMS.ID - [https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6](https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6)).

Currently, the query is designed to collect information from the “LTER Zöbelboden” site (DEIMS.ID - [https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6](https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6)), which, as of 30.01.2025, is record 676 in the list of sites here: [https://deims.org/api/sites](https://deims.org/api/sites).

Change line 465 of the [`siteSparqlGenerate.txt`](siteSparqlGenerate.txt) file for execute this query for other site. Change the value in "$[:10]" to execute the query only for the first ten items in the list of sites (https://deims.org/api/sites).


In the case of a **DEIMS-SDR network**, the work can be reproduced following this two files:
- [`networkSparqlGenerate.txt`](networkSparqlGenerate.txt) contains the SPARQL-Generate code to generate RDF for a network, including its relationships with other networks;

- [`networkRDF.ttl`](networkRDF.ttl) contains the result of the SPARQL-Generate query for the network "LTER Europe" (DEIMS.ID - [https://deims.org/networks/4742ffca-65ac-4aae-815f-83738500a1fc](https://deims.org/networks/4742ffca-65ac-4aae-815f-83738500a1fc)).

Currently, the query is designed to collect information from the “LTER Europe” network (DEIMS.ID - https://deims.org/networks/4742ffca-65ac-4aae-815f-83738500a1fc), which, as of 30.01.2025, is record 55 in the list of sites here: https://deims.org/api/networks.

Change line 42 of the [`networkSparqlGenerate.txt`](networkSparqlGenerate.txt) file for execute this query for other network. Change the value in "$[:10]" to execute the query only for the first ten items in the list of sites (https://deims.org/api/networks).

To reproduce the results, simply copy the content of the [`siteSparqlGenerate.txt`](siteSparqlGenerate.txt) or [`networkSparqlGenerate.txt`](networkSparqlGenerate.txt) file into the playground on the http://sparql-generate.org/ website and click "Run".
The output will be an RDF file in Turtle format, which can be saved with a `.ttl` extension.


To explore the mapping of API metadata elements to various ontology and vocabulary properties across different DEIMS-SDR resources, refer to the following files:
- [`mappingSite2RDF.md`](mappingSite2RDF.md) for sites;

- [`mappingNetwork2RDF.md`](mappingNetwork2RDF.md) for networks;

- [`mappingActivity2RDF.md`](mappingActivity2RDF.md) for activities;

- [`mappingDataset2RDF.md`](mappingDataset2RDF.md) for datasets;

- [`mappingLocation2RDF.md`](mappingLocation2RDF.md) for locations;

- [`mappingSensor2RDF.md`](mappingSensor2RDF.md) for sensors.


This repository also includes JSON files, as examples, from the DEIMS-SDR APIs for the various mapped resources:
- [`site.json`](site.json) for site, if you need to view the original version of this resource, please visit this [page](https://deims.org/api/sites/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6);

- [`network.json`](network.json) for network, if you need to view the original version of this resource, please visit this [page](https://deims.org/api/networks/4742ffca-65ac-4aae-815f-83738500a1fc);

- [`activity.json`](activity.json) for activity, if you need to view the original version of this resource, please visit this [page](https://deims.org/api/activities/4efaa2f2-6f4a-4f75-b95c-c3ffb13594a5);

- [`dataset.json`](dataset.json) for dataset, if you need to view the original version of this resource, please visit this [page](https://deims.org/api/datasets/cd1fb6f8-5e57-11e3-aa73-005056ab003f);

- [`location.json`](location.json) for location, if you need to view the original version of this resource, please visit this [page](https://deims.org/api/locations/12b38f3f-7e72-425a-80c7-7cad35ce4c7b);

- [`sensor.json`](sensor.json) for sensor, if you need to view the original version of this resource, please visit this [page](https://deims.org/api/sensors/fb583610-fe71-4793-b1a9-43097ed5c3e3).

## Acknowledgements
This work has been partially funded from the European Union's Horizon 2020 and Horizon Europe research and innovation programmes under the [H2020 eLTER-Plus Project](https://elter-ri.eu/elter-plus) grant agreement Nr. 871128 and [eLTER EnRich Project](https://elter-ri.eu/elter-enrich) grant agreement Nr. 101131751.
