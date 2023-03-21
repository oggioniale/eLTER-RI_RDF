Mapping of DEIMS-SDR Network JSON onto Environmental Monitoring Facility Vocabulary SmOD.
# Mapping based on the network <https://deims.org/networks/7fef6b73-e5cb-4cd2-b438-ed32eb1504b3>

||**jsonPath**|**JSON data item example**|**Translation into SmOD** |**Notes**|
| :- | :- | :- | :- | :- |
|1|$.concat($.id.prefix, $.id.suffix)|<p>"id": {</p><p>`    `"prefix": "<https://deims.org/networks/>",</p><p>`    `"suffix": "7fef6b73-e5cb-4cd2-b438-ed32eb1504b3"</p><p>`  `},</p><p></p>|<<https://deims.org/networks/7fef6b73-e5cb-4cd2-b438-ed32eb1504b3>> a ef:EnvironmentalMonitoringNetwork||
|2|$.title|"title": "LTER Italia (Italy)"|ef:name "LTER Italia (Italy)"|-|
|3|$.attributes.abstract|"attributes": {"abstract": "The Italian LTER network"}|dct:description "The Italian LTER network"|-|
|4|$.created|"created": "2012-10-22T11:29:20+0200"|<p>*dct:temporal [ a dct:PeriodOfTime ;*</p><p>`    `*dcat:startDate "2012-10-22T11:29:20+0200"^^xsd:date ;*</p><p>`    `*dcat:endDate ""^^xsd:date ;*</p><p>`  `*] ;*</p>|ef:operationalActivityPeriod property is currently missing in SmOD|
|5|$..belongsTo[\*]|<p>[</p><p>`  `{</p><p>`    `"type": "network",</p><p>`    `"title": "ILTER",</p><p>`    `"id": {</p><p>`      `"prefix": "https://deims.org/networks/",</p><p>`      `"suffix": "1aa7ccb2-a14b-43d6-90ac-5e0a6bc1d65b"</p><p>`    `}</p><p>`  `},</p><p>`  `{</p><p>`    `"type": "network",</p><p>`    `"title": "LTER Europe",</p><p>`    `"id": {</p><p>`      `"prefix": "https://deims.org/networks/",</p><p>`      `"suffix": "4742ffca-65ac-4aae-815f-83738500a1fc"</p><p>`    `}</p><p>`  `}</p><p>]</p><p></p>|*ef:narrower <https://deims.org/ "8ffe6c61-5473-4e56-9a6e-827baad941e5> ;*||
|12|$..consistsOf[\*]||*ef:contains <> ;*|link to network(s)|
#
