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


 


## Mapping based on the Activity <https://deims.org/activity/08dbd115-758e-4edc-ad26-2c820a32fb53>

|     | <b>jsonPath</b>  | <b>JSON data item example</b>  | <b>Translation into SmOD</b>   | <b>Notes</b>  | <b>EMF XML example</b>  |
| --- | ---------------- | ------------------------------ | ------------------------------ | ------------- | ----------------------- |

