# IA Node Repositories

**Repository:** `integration-architecture-documentation`  
**Description:** `This file provides a listing of the different Integration Architecture components and their repositories.`  
<!-- SPDX-License-Identifier: OGL-UK-3.0 -->

IA Node has a codebase for different functions and apps spread across various repositories. Here is a list of repositories you will find useful for discovering, setting up and configuring your own IA node.

 |   Repository         |     Description                        | Additional Information | 
|------------|-----------------------------|---------|
| [aws-integration-testing](https://github.com/National-Digital-Twin/aws-integration-testing)    |      This repository contains the codebase for testing integration between AWS and GitHub.                 |      -   |        |             |
|            [data-extractor](https://github.com/National-Digital-Twin/data-extractor)| This repository contains the codebase for data extrator which is a script that can query qn IA node and upload the resultant data to an AWS S3 bucket.               | -     |        |
|            [federator](https://github.com/National-Digital-Twin/federator)| This repository contains the codebase for the federator service which allows data exchange between Integration Architecture nodes.                | -    |        |
|            [fuseki-yaml-config](https://github.com/National-Digital-Twin/fuseki-yaml-config)| This repository contains the codebase for a tool for translating Yaml files to standard Fuseki config files - consists of a Yaml parser and RDF generator.               | -     |        |
|            [graphql-jena](https://github.com/National-Digital-Twin/graphql-jena)| This repository contains the codebase for an Apache Jena extension that provides GraphQL query capabilities.               | -    |        |
|            [ianode-access](https://github.com/National-Digital-Twin/ianode-access)| This repository contains the codebase for IANode APIs and services for mapping identity to user attributes for ABAC (Attribute Based Access Control) purposes.               | -     |        |
|            [jena-fuseki-kafka](https://github.com/National-Digital-Twin/jena-fuseki-kafka)| Provides integration with Kafka streams. This allows RDF (Resource Description Framework) data to be received and manipulated via messages on the Kafta streams.               | -     |        |
|            [jwt-servlet-auth](https://github.com/National-Digital-Twin/jwt-servlet-auth)| This repository contains a set of libraries that allows the addition of JSON Web Token (JWT) Bearer authentication into Java Servlet applications.               | -     |        |
|            [rdf-abac](https://github.com/National-Digital-Twin/rdf-abac)| This repository contains the codebase that provides the mechanism for fine-grained ABAC (Attribute Based Access Control) to RDF (Resource Description Framework) data as a plug-in for use by secure-agent-graph.             | -     |        |
|            [secure-agent-graph](https://github.com/National-Digital-Twin/secure-agent-graph)| This repository contains the codebase that provides the libraries and mechanism for receiving and holding RDF (Resource Description Framework) data. It also provides SPARQL access and integration points such as with ABAC components for security and control over data access.               | It makes use of Apache Jena and includes support for integration with Kafka. These are libraries for building Secure Agent implementations in Java. It also contains an API for defining pipelines as well as admin oriented APIs for invoking and running pipelines and API servers.    |        |
|            [secure-agents-lib](https://github.com/National-Digital-Twin/secure-agents-lib)| This repository contains libraries intended for rapid Secure Agents implementations in Java.               | It provides a lightweight functional API for defining pipelines as well as more admin/operations oriented APIs for invoking and running Secure Agents pipelines and API Servers.      |        |

© Crown Copyright 2025. This work has been developed by the National Digital Twin Programme and is legally attributed to the Department for Business and Trade (UK) as the governing entity.  
Licensed under the Open Government Licence v3.0.  
