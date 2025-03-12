# Data Ingestion Components
## Outlines the components involved with data ingestion into IA Node.

The **IA Node** components involved with data ingestion are:  
- [Secure Agent Graph](https://github.com/National-Digital-Twin/secure-agent-graph) – This is the primary component supporting **Apache Jena Fuseki SPARQL** queries which is one of the 3 [data injestion methods](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IANode/data-ingestion-methods.md) used by IA Node.  
- [Jena Fuseki Kafka extension module](https://github.com/National-Digital-Twin/jena-fuseki-kafka) – This enables data ingestion from **Kafka topics** which is one of the [data injestion methods](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IANode/data-ingestion-methods.md).  

> For details on deploying **Secure Agent Graph** locally, refer to the [Running an IA Node Locally](../Deployment/DeploymentLocal.md).  

---
