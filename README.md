## Aim of the work
The idea is to produce a copy of the shared entities through DEIMS-SDR (Dynamic Ecological Information Management System - Site and dataset registry) in an RDF format that can be used for creating a knowledge graph. This work was inspired by and originated from the work carried out in [![](https://img.shields.io/badge/doi-10.5281/zenodo.7313046-yellow.svg)](https://doi.org/10.5281/zenodo.7313046).

## Approach
In this work, the SPARQL GENERATE query language is used to generate RDF data from the DEIMS-SDR API. The SPARQL GENERATE query language allows the generation of RDF data from a SPARQL query. The SPARQL GENERATE query language is supported by the SPARQL-generate engine[^1], which is available as a web service at [http://sparql-generate.org/](http://sparql-generate.org/).

SPARQL-Generate is an expressive template-based language to generate RDF streams or text streams from RDF datasets and document streams in arbitrary formats (e.g. JSON, CSV, txt). It is based on SPARQL and extends it with capabilities for template-based query, transformation, and serialization. 

SPARQL-Generate is a W3C member submission, and it is currently under review by the W3C RDF Data Shapes Working Group.

# How is work organized?
Thanks to the use of the SPARQL-Generate engine, it is possible to generate graphs related to a site or a network. In particular, for a site, it also allows generating all related resources, such as datasets, sensors, activities, locations, as well as people, organizations, and projects, along with the relationships between them.  

In the case of a DEIMS-SDR site, the work can be reproduced following this two files:  
- [`siteSparqlGenerate.txt`](siteSparqlGenerate.txt) contains the SPARQL-Generate code to generate RDF for a site, dataset(s), sensor(s), activities, locations, people, organizations, and projects, including the relationships between these resources;
- [`siteRDF.ttl`](siteRDF.ttl) contains the result of the SPARQL-Generate query for the site "LTER Zöbelboden" (DEIMS.ID - [https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6](https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6)).
Currently, the query is designed to collect information from the “LTER Zöbelboden” site (DEIMS.ID - [https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6](https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6)), which, as of 30.01.2025, is record 676 in the list of sites here: [https://deims.org/api/sites](https://deims.org/api/sites).
Change line 416 of the [`siteSparqlGenerate.txt`](siteSparqlGenerate.txt) file for execute this query for other site. Change the value in "$[:10]" to execute the query only for the first ten items in the list of sites (https://deims.org/api/sites).

In the case of a DEIMS-SDR network, the work can be reproduced following this two files:
- [`networkSparqlGenerate.txt`](networkSparqlGenerate.txt) contains the SPARQL-Generate code to generate RDF for a network, including its relationships with other networks;
- [`networkRDF.ttl`](networkRDF.ttl) contains the result of the SPARQL-Generate query for the network "LTER Europe" (DEIMS.ID - [https://deims.org/networks/4742ffca-65ac-4aae-815f-83738500a1fc](https://deims.org/networks/4742ffca-65ac-4aae-815f-83738500a1fc)).
Currently, the query is designed to collect information from the “LTER Europe” network (DEIMS.ID - https://deims.org/networks/4742ffca-65ac-4aae-815f-83738500a1fc), which, as of 30.01.2025, is record 55 in the list of sites here: https://deims.org/api/networks.
Change line 42 of the [`networkSparqlGenerate.txt`](networkSparqlGenerate.txt) file for execute this query for other network. Change the value in "$[:10]" to execute the query only for the first ten items in the list of sites (https://deims.org/api/networks).

To reproduce the results, simply copy the content of the [`siteSparqlGenerate.txt`](siteSparqlGenerate.txt) or [`networkSparqlGenerate.txt`](networkSparqlGenerate.txt) file into the playground on the http://sparql-generate.org/ website and click "Run". The output will be an RDF file in Turtle format, which can be saved with a `.ttl` extension.

To view the mapping performed for the various entities, refer to the following files:
- [`mappingSite2RDF.md`](mappingSite2RDF.md) for sites;

- [`mappingNetwork2RDF.md`](mappingNetwork2RDF.md) for networks;

- [`mappingActivity2RDF.md`](mappingActivity2RDF.md) for activities;

- [`mappingDataset2RDF.md`](mappingDataset2RDF.md) for datasets;

- [`mappingLocation2RDF.md`](mappingLocation2RDF.md) for locations;

- [`mappingSensor2RDF.md`](mappingSensor2RDF.md) for sensors.

In questo repository sono stati anche inclusi i file JSON relativi alle API di DEIMS-SDR per le varie risorse mappate:
- [`site.json`](site.json) per i siti;

- [`network.json`](network.json) per le reti;

- [`activity.json`](activity.json) per le attività;

- [`dataset.json`](dataset.json) per i dataset;

- [`location.json`](location.json) per le locazioni;

- [`sensor.json`](sensor.json) per i sensori.

## Bibliography
[^1] Maxime Lefrançois, Antoine Zimmermann, Noorani Bakerally A SPARQL extension for generating RDF from heterogeneous formats, In Proc. Extended Semantic Web Conference, ESWC, May 2017, Portoroz, Slovenia. [PDF](https://hal.archives-ouvertes.fr/hal-01518617/file/sparql-generate-eswc2017.pdf)

## Acknowledgements
This work has been partially funded from the European Union's Horizon 2020 and Horizon Europe research and innovation programmes under the [H2020 eLTER-Plus Project](https://elter-ri.eu/elter-plus) grant agreement Nr. 871128 and [eLTER EnRich Project](https://elter-ri.eu/elter-enrich) grant agreement Nr. 101131751.