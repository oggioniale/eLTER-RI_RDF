# Mapping of DEIMS-SDR's site entity provided in JSON moreover using Environmental Monitoring Facility Vocabulary [(SmOD)](https://www.w3.org/2015/03/inspire/ef), Dublin core terms [(DC)](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/), Semantic Sensor Network ontology [(SSN)](https://w3c.github.io/sdw-sosa-ssn/ssn/) and Sensor, Observation, Sample, and Actuator [(SOSA)](https://w3c.github.io/sdw-sosa-ssn/ssn/), Friends Of A Friends vocabulary [(FOAF)](http://xmlns.com/foaf/spec/), Data Catalog Vocabulary [(DCAT)](https://semiceu.github.io/DCAT-AP/releases/3.0.0/) and Provenance ontology [(PROV-O)](https://www.w3.org/TR/prov-o/).

Authors: Alessandro Oggioni [^1]
[^1]: alessandro.oggioni@cnr.it

Namespaces and prefixes used in this documentation:

| **Prefix** | **Namespace IRI** |
| ---------- | ----------------- |
| ef | http://www.w3.org/2015/03/inspire/ef# |
| prov | http://www.w3.org/ns/prov# |
| dc | http://purl.org/dc/elements/1.1/ |
| dct | http://purl.org/dc/terms/ |
| foaf | http://xmlns.com/foaf/0.1/ |
| rdf | http://www.w3.org/1999/02/22-rdf-syntax-ns# |
| rdfs | http://www.w3.org/2000/01/rdf-schema# |
| dcterm | http://purl.org/dc/terms/ |
| dcterms | http://purl.org/dc/terms/ |
| dcat | http://www.w3.org/ns/dcat# |
| geosparql | http://www.opengis.net/ont/geosparql# |
| geo | http://www.opengis.net/ont/geosparql# |
| locn | http://www.w3.org/ns/locn# |
| sosa | http://www.w3.org/ns/sosa/ |
| ssn | http://www.w3.org/ns/ssn/ |
| xsd | http://www.w3.org/2001/XMLSchema# |
| ite | http://w3id.org/sparql-generate/iter/ |
| fun | http://w3id.org/sparql-generate/fn/ |
| owl | http://www.w3.org/2002/07/owl# |

## Sites metadata elements mapping, based on the “LTER Zöbelboden” site (DEIMS.ID - https://deims.org/sites/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6). See also [JSON file for this site](site.json)

| **level** | **DEIMS-SDR site metadata element** | **JSON path (evaluated with Jayway JsonPath - https://sumiya.page)** | **JSON data item example** | **RDF rendering** | **notes** |
| --------- | ----------------------------------- | -------------------------------------------------------------------- | -------------------------- | ----------------- | --------- |
| 1	| title	| \$.title	| `"LTER Zöbelboden - Austria"`	| `ef:name "LTER Zöbelboden - Austria"@en` | 
| 2	| id	| concat( \$.id.prefix, \$.id.suffix) | `"https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6"` | `<https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6> rdf:type ef:EnvironmentalMonitoringFacility , prov:Entity` |
| 3	| type | $.type	| `"site"` | `ef:specialisedEMFType ‘site’@en` |
| 4	| created	| $.created	| `"2012-12-25T18:53:54+0100"` | `dcterms:issued "2012-12-25T18:53:54+0100"^^xsd:dateTime` |
| 5	| changed	| $.changed	| `"2025-01-07T11:14:56+0100"` | `dct:modified "2025-01-07T11:14:56+0100"^^xsd:dateTime` |
| 6.1.1	| attributes.affiliation.network | $.attributes.affiliation.networks[*].network.id.suffix	| `[ "a020d91b-500b-474e-948b-cf5856121cb2", "c3abdc60-49f1-49db-81fe-863b7dbb21d3", … ]`	| `ef:belongsTo <https://deims.org/network/ a020d91b-500b-474e-948b-cf5856121cb2> , <https://deims.org/network/c3abdc60-49f1-49db-81fe-863b7dbb21d3> , …`	| by concatenating the suffix with the string 'https://deims.org/network/' and iterating over each of the obtained suffixes |
| 6.1.2	| attributes.affiliation.projects	| $.attributes.affiliation.projects[?(@.uri != null)]	| `[ "https://cordis.europa.eu/project/id/641762", "http://www.enveurope.eu/", "https://www.expeeronline.eu/", … ]`	| `prov:wasGeneratedBy <http://www.enveurope.eu/> , <https://cordis.europa.eu/project/id/820852> , …`	| only for the project(s) with URI |
| | | | `<https://cordis.europa.eu/project/id/820852> rdf:type foaf:Project; foaf:name "e-shape (H2020)"@en` | for create project(s) node |
| 6.2.1	| attributes.contact.siteManager | $.attributes.contact.siteManager[*].[?(@.type == 'person')].[?(@.orcid != null)] | `[{ "type": "person", "name": "Thomas Dirnboeck", "email": "thomas.dirnboeck@umweltbundesamt.at", "orcid": "https://orcid.org/0000-0002-8294-0690"}]` | `dcat:contactPoint <https://orcid.org/0000-0002-8294-0690>` | iterating over each of the obtained site manager |
| | | | | <https://orcid.org/0000-0002-8294-0690> rdf:type prov:Agent , foaf:Person; foaf:fullName "Thomas Dirnboeck"; foaf:hasEmail <mailto:thomas.dirnboeck@umweltbundesamt.at>	| with the aim of creating a new node for the site manager graph. Iterating over each of the obtained site manager. |
| 6.2.2 | attributes.contact.operatingOrganization | $.attributes.contact.operatingOrganisation[?(@.type == 'organisation')].[?(@.ror != null)] | `[{ "type": "organisation", "name": "Environment Agency Austria (EAA)", "url": "http://www.umweltbundesamt.at/", "ror": "https://ror.org/013vyke20" }]`	| `<https://ror.org/013vyke20> rdf:type foaf:Organization; foaf:homepage  <http://www.umweltbundesamt.at/>; foaf:name "Environment Agency Austria (EAA)"@en` | with the aim of creating a new node for the operation organizations graph. Iterating over each of the obtained operating organizations. |
| | | | | `dct:publisher <https://ror.org/013vyke20>`	| with the aim to have the property dct:publisher expressed in site related with operating organization ID (ROR) |
| 6.2.3 | attributes.contact.metadataProvider	| $.attributes.contact.metadataProvider[*].[?(@.type == 'person')].[?(@.orcid != null)]	| `[{ "type": "person", "name": "Johannes Kobler", "email": "johannes.kobler@umweltbundesamt.at", "orcid": "https://orcid.org/0000-0003-0052-4245" }, { "type": "person", "name": "Johannes Peterseil", "email": "johannes.peterseil@umweltbundesamt.at", "orcid": "https://orcid.org/0000-0003-0631-8231" }, … ]` | - | the property for link metadata provider with site is not yet identified |
| | | | | `<https://orcid.org/0000-0003-0052-4245> rdf:type prov:Agent , foaf:Person; foaf:fullName "Johannes Kobler"; foaf:hasEmail <mailto:johannes.kobler@umweltbundesamt.at> , …` | with the aim of creating a new node for the site manager graph. Iterating over each of the obtained site manager. |
| 6.2.4	| attributes.contact.fundingAgency | $.attributes.contact.fundingAgency[?(@.type == 'organisation')].[?(@.ror != null)] | `[{ "type": "organisation", "name": "Environment Agency Austria (EAA)", "url": "http://www.umweltbundesamt.at/", "ror": "https://ror.org/013vyke20" }]`	| `<https://ror.org/013vyke20> rdf:type foaf:Organization; foaf:homepage  <http://www.umweltbundesamt.at/>; foaf:name "Environment Agency Austria (EAA)"@en` | with the aim of creating a new node for the funding agency graph | 
| | | | | - | the property to link founding agency with site is not yet identified |
| 6.2.5 | attributes.contact.siteUrl | $.attributes.contact.siteUrl[*] | `[{ "title": "Zöbelboden (german long version)", "value": "https://www.umweltbundesamt.at/umweltthemen/oekosystemmonitoring/zoebelboden" }, … ]`	| -	| not included |
| 6.3.1	| attributes.general.abstract	| $.attributes.general.abstract	| `"The Zöbelboden was established in 1992 as the only Integrated Monitoring station in Austria under the UN …"` | `dct:description "The Zöbelboden was established in 1992 as the only Integrated Monitoring station in Austria under the UN …"` | |
| 6.3.2	| attributes.general.citation	| $.attributes.general.citation	| `"Zöbelboden (1992), Austria. Mountain forest ecosystem … "` | - | not included |
| 6.3.3	| attributes.general.relatedIdentifiers	| $.attributes.general.relatedIdentifiers | `null` | - | not included |
| 6.3.4	| attributes.general.status	| $.attributes.general.status	| `{ "label": "Operational", "uri": "http://codes.wmo.int/wmdr/ReportingStatus/operational" }`	| -	| not included |
| 6.3.5	| attributes.general.yearEstablished | $.attributes.general.yearEstablished | `1992` | `dcat:startDate "1992"^^xsd:date` | | |
| 6.3.6 | attributes.general.yearClosed | $.attributes.general.yearClosed | `dcat:endDate ""^^xsd:date` | | |
| 6.3.7 | attributes.general.relatedSites | $.attributes.general.relatedSites[?(@.typeOfRelationship.label == 'belongs to')].listOfSites[*].id[?(@.suffix != null)].suffix | `["d0a8da18-0881-4ebe-bccf-bc4cb4e25701"]` | `ef:broader <https://deims.org/d0a8da18-0881-4ebe-bccf-bc4cb4e25701>` | parent site |
| | | $.attributes.general.relatedSites[?(@.typeOfRelationship.label == 'contains')].listOfSites[*].id[?(@.suffix != null)].suffix | `null` | `ef:narrower` | children site |
| 6.3.8	| attributes.general.siteName	| $.attributes.general.siteName | `"LTER Zöbelboden"`	| -	| not included |
| 6.3.9 |	attributes.general.shortName | $.attributes.general.shortName | `"Zöbelboden"` | - | not included |
| 6.3.10 | attributes.general.siteType	| $.attributes.general.siteType	| `"Stationary land-based site"` | - | not included |
| 6.3.11 | attributes.general.protectionLevel | $.attributes.general.protectionLevel | `[{"label": "Category II – National Park", "uri": "http://dd.eionet.europa.eu/vocabularyconcept/cdda/IucnCategoryValue/II" }]` | - | not yet included |
| 6.3.12 | attributes.general.landUse | $.attributes.general.landUse | `[{ "label": "accommodation and food services", "uri": "https://inspire.ec.europa.eu/codelist/HILUCSValue/3_1_3_AccommodationAndFoodServices" }, … ]` | - | not included |
| 6.3.13 | attributes.general.images	| $.attributes.general.images	| `[{ "url": "https://deims.org/sites/default/files/photos/lter-zobelboden-austria_6805.jpg", "alt": "Automatic chamber for soil carbon respiration " }, … ]` | -	| not included |
| 6.4.1 | attributes.environmentalCharacteristics.airTemperature | $.attributes.environmentalCharacteristics.airTemperature | `{ "yearlyAverage": 7.2, "monthlyAverage": [ -0.55, … ], … }`	| -	| not included |
| 6.4.2	| attributes.environmentalCharacteristics.precipitation	| $.attributes.environmentalCharacteristics.precipitation	| `{ "yearlyAverage": 1600, "monthlyAverage": [ 129, … ], … }`	| -	| not included |
| 6.4.3	| attributes.environmentalCharacteristics.biogeographicalRegion	| $.attributes.environmentalCharacteristics.biogeographicalRegion	| `"alpine"` | - | not included |
| 6.4.4	| attributes.environmentalCharacteristics.biome	| $.attributes.environmentalCharacteristics.biome	| `"mixed_forest"` | - | not included |
| 6.4.5	| attributes.environmentalCharacteristics.ecosystemType	| $.attributes.environmentalCharacteristics.ecosystemType	| `[{ "label": "Forest", "uri": null }, … ]`	| `ef:mediaMonitored "Forest"@en`	| |
| 6.4.6 | attributes.environmentalCharacteristics.eunisHabitat | $.attributes.environmentalCharacteristics.eunisHabitat | `[{ "label": "Beech woodland (G1.6)", "uri": null}, … ]`	| `ef:mediaMonitored "Beech woodland (G1.6)"@en` | |
| 6.4.7	| attributes.environmentalCharacteristics.landforms	| $.attributes.environmentalCharacteristics.landforms	| `[{"label": "Mountain", "uri": null }]` | -	| not included |
| 6.4.8	| attributes.environmentalCharacteristics.geoBonBiome	| $.attributes.environmentalCharacteristics.geoBonBiome	| `[ "Terrestrial" ]`	| `ef:mediaMonitored "Terrestrial"@en` | |
| 6.4.9	| attributes.environmentalCharacteristics.geology	| $.attributes.environmentalCharacteristics.geology	| `"The main rock type is Norian dolomite (Hauptdolomit), which …"`	| -	| not included |
| 6.4.10 | attributes.environmentalCharacteristics.hydrology | $.attributes.environmentalCharacteristics.hydrology	| `"The watershed can be divided into two distinct sites: A …"`	| -	| not included |
| 6.4.11 | attributes.environmentalCharacteristics.soils | $.attributes.environmentalCharacteristics.soils | `"Intensive plot I (IP I) is located on the plateau …"` | -	| not included |
| 6.4.12 | attributes.environmentalCharacteristics.vegetation	| $.attributes.environmentalCharacteristics.vegetation | `"The mean slopes are 14° at IP I and 36° at IP II. IP I is dominated …"`	| -	| not included |
| 6.5.1	| attributes.geographic.boundaries | $.attributes.geographic.boundaries	| `"POLYGON ((14.435456610419 47.83985714374, 14.435472337769 47.840552573525, 14.435427899355 …"` | `dcterms:spatial [ rdf:type dcterms:Location; locn:geometry "<http://www.opengis.net/def/crs/EPSG/0/4326> POLYGON ((14.435456610419 47.83985714374, 14.435472337769 47.840552573525, 14.435427899355 …"^^geosparql:wktLiteral ]` | | |	
| 6.5.2	| attributes.geographic.coordinates	| $.attributes.geographic.coordinates	| `"POINT (14.444136161386 47.842246069311)"`	| `dcterms:spatial [ rdf:type dcterms:Location; dcat:centroid  "<http://www.opengis.net/def/crs/EPSG/0/4326> POINT (14.444136161386 47.842246069311)"^^geosparql:wktLiteral]`	| | |
| 6.5.3	| attributes.geographic.country	| $.attributes.geographic.country	| `[ "Austria" ]`	| -	| not included | 
| 6.5.4	| attributes.geographic.elevation	| $.attributes.geographic.elevation	| `{ "avg": 831, "min": 516, "max": 955, "unit": "msl" }`	| -	| not included | 
| 6.5.5	| attributes.geographic.size | $.attributes.geographic.size | `{ "value": 90, "unit": "ha" }`	| -	| not included | 
| 6.5.6	| attributes.geographic.relatedLocation	| $.attributes.geographic.relatedLocations | `[{ "title": "LTER Zöbelboden, Austria, Project area", "id": { "prefix": "https://deims.org/locations/", "suffix": "12b38f3f-7e72-425a-80c7-7cad35ce4c7b" }, "changed": "2024-05-07T14:22:05+0200" }, … "` | `ef:contains <https://deims.org/locations/12b38f3f-7e72-425a-80c7-7cad35ce4c7b> , …` | | |
| 6.6.1	| attributes.focusDesignScale.experiments	| $.attributes.focusDesignScale.experiments	| `{ "design": "partly experimentation", "scale": "plot scale" }`	| -	| not included | 
| 6.6.2 | attributes.focusDesignScale.observations | $.attributes.focusDesignScale.observations | `{ "design": "mainly observation", "scale": "entire catchment" }`	| -	| not included | 
| 6.6.3	| attributes.focusDesignScale.obsevedProperties	| $.attributes.focusDesignScale.observedProperties[*].uri	| `["http://vocabs.lter-europe.net/EnvThes/21476","http://vocabs.lter-europe.net/EnvThes/22025", … ]` | `ef:observedProperty <http://vocabs.lter-europe.net/EnvThes/21476> , <http://vocabs.lter-europe.net/EnvThes/22025> , …` | | |
| 6.7.1	| attributes.infrastructure.accessibleAllYear	| $.attributes.infrastructure.accessibleAllYear	| `true` | -	| not included | 
| 6.7.2	| attributes.infrastructure.accessType | $.attributes.infrastructure.accessType | `"dirt road (4WD)"` | -	| not included | 
| 6.7.3	| attributes.infrastructure.allPartsAccessible | $.attributes.infrastructure.allPartsAccessible | `false`	| -	| not included | 
| 6.7.4	| attributes.infrastructure.maintenaceInterval | $.attributes.infrastructure.maintenanceInterval | `30`	| -	| not included | 
| 6.7.5	| attributes.infrastructure.permanentPowerSupply | $.attributes.infrastructure.permanentPowerSupply | `true` | - | not included | 
| 6.7.6	| attributes.infrastructure.operation	| $.attributes.infrastructure.operation	| `{ "permanent": true, "notes": "The Zöbelboden is managed by the Umweltbundesamt GmbH. Sampling …", "siteVisitInterval": 7}` | - | not included |
| 6.7.7	| attributes.infrastructure.notes | $.attributes.infrastructure.notes | `"The Zöbelboden covers a small forested catchment (90 ha) …"`	| -	| not included |
| 6.7.8	| attributes.infrastructure.collection | $.attributes.infrastructure.collection | `[{ "label": "1 - 5 beds", "uri": null }, … ]`	| -	| not included |
| 6.7.9	| attributes.infrastructure.data | $.attributes.infrastructure.data | `{"policy": { "url": null, "rights": [ "Formal acknowledgement of the dataset providers" ], "notes": "Our data is free upon request, just write us or call us."}}`	| -	| not included |
| 6.8	| attributes.relatedResources	| $.attributes.relatedResources[*].[?(@.id.prefix=='https://deims.org/activity/')].id[?(@.suffix != null)].suffix	| `[ "4efaa2f2-6f4a-4f75-b95c-c3ffb13594a5", "94016f3b-2e6b-4f95-a759-1b0a40126dcd", … ]`	| `ef:involvedIn <https://deims.org/activity/4efaa2f2-6f4a-4f75-b95c-c3ffb13594a5> , <https://deims.org/activity/94016f3b-2e6b-4f95-a759-1b0a40126dcd> , …`	| [Activity - see mapping](mapping_Activity2RDF.md) |
| | | $.attributes.relatedResources[*].[?(@.id.prefix=='https://deims.org/sensors/')].id[?(@.suffix != null)].suffix | `[ "fb583610-fe71-4793-b1a9-43097ed5c3e3" ]`	| `ef:narrow <https://deims.org/sensors/fb583610-fe71-4793-b1a9-43097ed5c3e3>` | [Sensor - see mapping](mapping_Sensor2RDF.md) |
| | | $.attributes[?(@.relatedResources != null)].relatedResources[?(@.id.prefix=='https://deims.org/dataset/')].id[?(@.suffix != null)].suffix	| `[ "cd1fb6f8-5e57-11e3-aa73-005056ab003f", "75a7f938-7c77-11e3-8832-005056ab003f", … ]`	| `ef:hasObservation <https://deims.org/dataset/cd1fb6f8-5e57-11e3-aa73-005056ab003f > , <https://deims.org/dataset/75a7f938-7c77-11e3-8832-005056ab003f > , …` | [Dataset - see mapping](mapping_Dataset2RDF.md) |
| 6.9	| attributes.projectRelated	| $.attributes.projectRelated	| `{ "lter": { "lterSiteClassification": "Master Site" } }`	| -	| not included |
