# Mapping of DEIMS-SDR Sites JSON onto Environmental Monitoring Facility Vocabulary SmOD.

Authors: Alessandro Oggioni [^1]
[^1]: oggioni.a@irea.cnr.it

## Sites metadata elements mapping, based on the “LTER Zöbelboden” site (DEIMS.ID - https://deims.org/api/sites/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6)

| **level** | **DEIMS-SDR site metadata element** | **JSON path (evaluated with Jayway JsonPath - https://sumiya.page)** | **JSON data item example** | **RDF rendering** | **notes** |
| --------- | ----------------------------------- | -------------------------------------------------------------------- | -------------------------- | ----------------- | --------- |
| 1	| title	| \$.title	| `"LTER Zöbelboden - Austria"`	| `ef:name "LTER Zöbelboden - Austria"@en` | 
| 2	| id	| concat($.id.prefix, $.id.suffix) | `"https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6"` | `<https://deims.org/8eda49e9-1f4e-4f3e-b58e-e0bb25dc32a6> rdf:type ef:EnvironmentalMonitoringFacility , prov:Entity` |
| 3	| type | $.type	| `"site"` | `ef:specialisedEMFType ‘site’@en` |
| 4	| created	| $.created	| `"2012-12-25T18:53:54+0100"` | `dcterms:issued "2012-12-25T18:53:54+0100"^^xsd:dateTime` |
| 5	| changed	| $.changed	| `"2025-01-07T11:14:56+0100"` | `dct:modified "2025-01-07T11:14:56+0100"^^xsd:dateTime` |
| 6.1.1	| attributes.affiliation.network | $.attributes.affiliation.networks[*].network.id.suffix	[
"a020d91b-500b-474e-948b-cf5856121cb2",
"c3abdc60-49f1-49db-81fe-863b7dbb21d3",
…
]	| ef:belongsTo <https://deims.org/network/ a020d91b-500b-474e-948b-cf5856121cb2> , <https://deims.org/network/c3abdc60-49f1-49db-81fe-863b7dbb21d3> , …	| by concatenating the suffix with the string 'https://deims.org/network/' and iterating over each of the obtained suffixes |
| 6.1.2	| attributes.affiliation.projects	$.attributes.affiliation.projects[?(@.uri != null)]	| [
"https://cordis.europa.eu/project/id/641762",
"http://www.enveurope.eu/",
"https://www.expeeronline.eu/",
…
]	| prov:wasGeneratedBy <http://www.enveurope.eu/> , <https://cordis.europa.eu/project/id/820852> , …	| only for the project(s) with URI |
| | | | <https://cordis.europa.eu/project/id/820852>
        rdf:type   foaf:Project;
        foaf:name  "e-shape (H2020)"@en | for create project(s) node |
| 6.2.1	| attributes.contact.siteManager | $.attributes.contact.siteManager[*].[?(@.type == 'person')]	[
	{
		"type": "person",
		"name": "Gisela Proell",
		"email": "gisela.proell@umweltbundesamt.at",
		"orcid": null
	},
	{
		"type": "person",
		"name": "Thomas Dirnboeck",
		"email": "thomas.dirnboeck@umweltbundesamt.at",
		"orcid": "https://orcid.org/0000-0002-8294-0690"
	}
]	| dcat:contactPoint  [ rdf:type prov:Person , foaf:Person; rdfs:seeAlso   <https://orcid.org/0000-0002-8294-0690>;
                                   foaf:fullName  "Thomas Dirnboeck";
                                   foaf:hasEmail  <mailto:thomas.dirnboeck@umweltbundesamt.at>
                                 ];
        dcat:contactPoint        [ rdf:type       prov:Person , foaf:Person;
                                   foaf:fullName  "Gisela Proell";
                                   foaf:hasEmail  <mailto:gisela.proell@umweltbundesamt.at>
                                 ] | iterating over each of the obtained persons |
| 6.2.2 | attributes.contact.operatingOrganization | $.attributes.contact.operatingOrganisation[?(@.type == 'organisation')].[?(@.ror != null)] | [
	{
		"type": "organisation",
		"name": "Environment Agency Austria (EAA)",
		"url": "http://www.umweltbundesamt.at/",
		"ror": "https://ror.org/013vyke20"
	}
]	<https://ror.org/013vyke20> rdf:type       foaf:Organization;
foaf:homepage  <http://www.umweltbundesamt.at/>;
foaf:name      "Environment Agency Austria (EAA)"@en |	with the aim of creating a new node for the organizations graph |
| |	|	|	dct:publisher <https://ror.org/013vyke20> | with the aim to have the property expressed in site |
| 6.2.3 | attributes.contact.metadataProvider | $.attributes.contact.metadataProvider[?(@.type == 'person')]	[
	{
		"type": "person",
		"name": "Gisela Proell",
		"email": "gisela.proell@umweltbundesamt.at",
		"orcid": null
	},
…
} |	-	| not yet included |



 


## Mapping based on the Activity <https://deims.org/activity/08dbd115-758e-4edc-ad26-2c820a32fb53>

|     | <b>jsonPath</b>  | <b>JSON data item example</b>  | <b>Translation into SmOD</b>   | <b>Notes</b>  | <b>EMF XML example</b>  |
| --- | ---------------- | ------------------------------ | ------------------------------ | ------------- | ----------------------- |

