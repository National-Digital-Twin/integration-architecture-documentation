# README  

**Repository:** integration-architecture-documentation 

**Description:** This repository provides the documentation and complete overview of the Integration Architecture (IA) project.  

<!-- SPDX-License-Identifier: OGL-UK-3.0 -->

## Overview  
This repository contributes to the development of **secure, scalable, and interoperable data-sharing infrastructure**. It supports NDTP’s mission to enable **trusted, federated, and decentralised** data-sharing across organisations.  

This repository is one of several open-source components that underpin NDTP’s **Integration Architecture (IA)**—a framework designed to allow organisations to manage and exchange data securely while maintaining control over their own information. The IA is actively deployed and tested across multiple sectors, ensuring its adaptability and alignment with real-world needs. 

## What is IA Node?
IA Node (Integration Architecture Node), is an open-source digital component developed as part of the National Digital Twin Programme (NDTP) to support managing and sharing information across organisations. NDTP facilates the pairing of physical real world objects or assets with a digital representation. The objective is to build a robust and sustainable digital twin ecosystem.  

## Features  
- **Core functionality** 
    - Supports secure and RDF (Resource Description Framework) data-sharing
    - Implements ABAC (Attribute-Based Access Control) data security
    - Supports OpenTelemetry
- **Key integrations** 
    - Provides REST and GraphQL API interfaces
    - Integrates with Apache Jena Fuseki server
    - Includes Fuseki-Kafka bridge for Kafka integration
    - Multi-cloud platform deployment
- **Scalability & performance** 
    - Optimised for high-throughput environments
    - Supports in-memory datasets for fast data access
- **Modularity** 
    - Designed with a plugin-based architecture for extensibility
    - Configurable using Fuseki configuration files and environment variables 

## Quick Start  
Follow these steps to get started quickly with this repository. For detailed installation, configuration, and deployment, refer to the relevant README and MD files within each repository.  

This Quick Start will guide you through the different repositories and the process of integrating, configuring and using IA Node. It will help you with understanding and getting started with spinning up your own IA node. 

Before planning and starting your own IA node, you should:  

- Get some [background](./DeveloperDocumentation/IANode/ia-node-background.md) understanding of IA Node.
- Get to know the different [repositories associated with IA Node](./DeveloperDocumentation/IANode/repositories.md).
- Understand [how data is ingested into an IA node](./DeveloperDocumentation/IANode/data-ingestion.md).
- Understand [how data is exchanged between IA nodes](https://github.com/National-Digital-Twin/federator/blob/main/README.md#introduction).
- Understand the [concept of a Producer and Consumer server](https://github.com/National-Digital-Twin/federator/blob/main/README.md#approach-to-data-exchange-between-ia-nodes)
- Understand [how to configure a new Producer and Consumer server](https://github.com/National-Digital-Twin/federator/blob/main/docs/new-client-server.md).
- Understand [how to extract data from an IA node](./DeveloperDocumentation/IANode/data-extraction.md) and the [data extractor app](https://github.com/National-Digital-Twin/data-extractor/blob/main/README.md#data-extractor).
- Understand [how to build and deploy an IA node](./DeveloperDocumentation/Deployment/deployment.md#deployment) and [run a basic test](./DeveloperDocumentation/Deployment/deployment-local.md#run-basic-test-for-minimal-ia-node-functionality).
- Reference the [glossary](./DeveloperDocumentation/IANode/glossary.md#glossary) to understand terms, definitions, and abbreviations relating to IA Node.


## Public Funding Acknowledgment  
This repository has been developed with public funding as part of the National Digital Twin Programme (NDTP), a UK Government initiative. NDTP, alongside its partners, has invested in this work to advance open, secure, and reusable digital twin technologies for any organisation, whether from the public or private sector, irrespective of size.  

## Licence  
This repository contains documentation which is covered by licenced under the [Open Government Licence (OGL) v3.0](OGL_LICENSE.md).  

By contributing to this repository, you agree that your contributions will be licensed under these terms.

See [LICENSE.md](LICENSE.md), [OGL_LICENCE.md](OGL_LICENCE.md), and [NOTICE.md](NOTICE.md) for details.  

## Security and Responsible Disclosure  
We take security seriously. If you believe you have found a security vulnerability in this repository, please follow our responsible disclosure process outlined in [SECURITY.md](SECURITY.md).  

## Contributing  
We welcome contributions that align with the Programme’s objectives. Please read our [Contributing](CONTRIBUTING.md) guidelines before submitting pull requests.  

## Acknowledgements  
This repository has benefited from collaboration with various organisations. For a list of acknowledgments, see [Acknowledgements](ACKNOWLEDGEMENTS.md).  

## Support and Contact  
For questions or support, check our Issues or contact the NDTP team on ndtp@businessandtrade.gov.uk.

**Maintained by the National Digital Twin Programme (NDTP).**  

© Crown Copyright 2025. This work has been developed by the National Digital Twin Programme and is legally attributed to the Department for Business and Trade (UK) as the governing entity.
