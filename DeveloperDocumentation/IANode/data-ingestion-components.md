# Data Ingestion Components

**Repository:** `integration-architecture-documentation`  
**Description:** `This file provides documentation on components involved in data ingestion into Integration Architecture Node (IA Node). `  
<!-- SPDX-License-Identifier: OGL-UK-3.0 --> 

The **IA Node** components involved with data ingestion are:  
- [Secure Agent Graph](https://github.com/National-Digital-Twin/secure-agent-graph) – This is the primary component supporting **Apache Jena Fuseki SPARQL** queries which is one of the 3 [data injestion methods](./data-ingestion-methods.md) used by IA Node.  
- [Jena Fuseki Kafka extension module](https://github.com/National-Digital-Twin/jena-fuseki-kafka) – This enables data ingestion from **Kafka topics** which is one of the [data injestion methods](./data-ingestion-methods.md).  

> For details on deploying **Secure Agent Graph** locally, refer to the [Running an IA Node Locally](../Deployment/deployment-local.md).  

---

© Crown Copyright 2025. This work has been developed by the National Digital Twin Programme and is legally attributed to the Department for Business and Trade (UK) as the governing entity.  
Licensed under the Open Government Licence v3.0.  

You can view the full license at:  
https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/
