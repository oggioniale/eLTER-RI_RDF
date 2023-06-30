# Mapping of DEIMS-SDR sensor JSON onto Semantic Sensor Network Ontology (SSN) and Sensor, Observation, Sample, and Actuator ontology (SOSA)

Authors: Cristiano Fugazza, Alessandro Oggioni and Paolo Tagliolato. [^1]
[^1]: {fugazza.c, oggioni.a, tagliolato.p}@irea.cnr.it

A first mapping of DEIMS-SDR is to SSN, SOSA, FOAF, and PROV-O. Only a few elements of DEIMS-SDR Sensor are mapping because the SSN and SOSA classes and properties don’t cover the complexity of the elements contained in DEIMS-SDR Sensor. FOAF is used for person and PROV-O for mapping different elements about provenance.

|**jsonPath**|**JSON data item example**|**Translation into SSN** |**Notes**|
| ---------------- | ------------------------------ | ----------------------------- | ------------- |
| $.concat($.id.prefix,$.id.suffix) | "https://deims.org/sensors/fb583610-fe71-4793-b1a9-43097ed5c3e3" | <https://deims.org/sensors/fb583610-fe71-4793-b1a9-43097ed5c3e3>        rdf:type               sosa:Sensor , prov:Entity ; |  |
| $.title | "LTER Zöbelboden Austria precipitation WW" | rdfs:label             "LTER Zöbelboden Austria precipitation WW"@en ; |  |
| $.attributes.observation[*].label | [	"precipitation sensor"] | <<a href='https://deims.org/sensors/115e55f5-25c6-45ee-b490-393269e7bb06'>https://deims.org/sensors/115e55f5-25c6-45ee-b490-393269e7bb06</a>> rdf:type sosa:Sensor ;  sosa:observes <{string obtained by JSON path}> . | # sosa:observes <{URI}> ; |
| <span style='background-color:rgb(255, 255, 255)'>$.concat($.attributes.general.relatedSite[0].id.prefix, $.attributes.general.relatedSite[0].id.suffix)</span> | "https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6" | sosa:isHostedBy <https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6> |  |
| $.attributes.general.contact[*] | [	{		"type": "organisation",		"name": "Environment Agency Austria (EAA)",		"url": "http://www.umweltbundesamt.at/"	},	{		"type": "person",		"name": "Thomas Dirnboeck",		"email": "thomas.dirnboeck@umweltbundesamt.at",		"orcid": "https://orcid.org/0000-0002-8294-0690"	}] | dcat:contactPoint      [ rdf:type       prov:Person , foaf:Person ;                                 rdfs:seeAlso   "https://orcid.org/0000-0002-8294-0690" ;                                 foaf:fullName  "Thomas Dirnboeck" ;                                 foaf:hasEmail  "thomas.dirnboeck@umweltbundesamt.at"                               ] ;        dcat:contactPoint      [ rdf:type       prov:Person , foaf:Person ;                                 rdfs:seeAlso   "http://www.umweltbundesamt.at/" ;                                 foaf:fullName  "Environment Agency Austria (EAA)"                               ] ; |  |
| $.attributes.general.abstract | "Precipitation measurement at LTER Zöbelboden Austria, Wildwiese (forest clearing area)" | rdfs:comment           "Precipitation measurement at LTER Zöbelboden Austria, Wildwiese (forest clearing area)"@en ; |  |
| $.attributes.geographic.coordinates | "POINT (14.442 47.842)" | geosparql:hasGeometry  [ rdf:type         sf:Point ;                                 geosparql:asWKT  "<urn:ogc:def:crs:EPSG::4283> POINT (14.442 47.842)"^^geosparql:wktLiteral                               ] ;andgeo:lat                "47.842" ;geo:lon                "14.442" ; |  |
| $.attributes.geographic.elevation.value | 893 | geo:alt 893 ; |  |


