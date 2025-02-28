# Getting Started
## Outlines what you can expect with IA Node.
Getting Started will guide you through the different repositories and the process of integrating, configuring and using IA Node. It will help you with understanding and getting started with spinning up your own IA Node. 

The table of content below is organised a such a way to help you get to the relevant information and repository you need to get you started with your IA Node.

1. [AI Node Background](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IANode/Context.md#ianode-context)

    1.1	[Introduction](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IANode/IANode.md#ianode)

    1.2 [Overview of IA Nodes](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IntegrationArchitecture.md#integration-architecture) 

	1.3 [Core functional components](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IANode/Components.md#ianode-components) 

    1.4 [IA Node Features](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IANode/Features.md#ianode-features)

	1.5 [IA Nodes networks](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/NodeNet.md#nodenet)

    1.6 [Managemant Node](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/NodeNet.md#nodenet)

	1.7 [Code repositories](#ia-node-repositories)

2. [Ingesting data into an IA Node](https://github.com/National-Digital-Twin/jena-fuseki-kafka?tab=readme-ov-file#jena-fuseki-kafka)

    2.1 [Introduction](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IANode/InAction.md#ianode-in-action) 

    2.2 [Data ingestion approaches](https://github.com/National-Digital-Twin/federator/blob/main/docs/design.md#federation-service-design)

    2.2 [Data ingestion with REST API](https://github.com/National-Digital-Twin/node-lib/blob/pre/docs/adapters.md#adapters) 

    2.3 [Data ingestion with Federators](https://github.com/National-Digital-Twin/federator/tree/doc/ia-360-Federator-ducmentation-exchange-of-data-between-ia-nodes?tab=readme-ov-file#table-of-contents)
 
3. [Exchanging Data between IA Nodes](https://github.com/National-Digital-Twin/federator/tree/doc/ia-360-Federator-ducmentation-exchange-of-data-between-ia-nodes?tab=readme-ov-file#overview-of-approach-to-ia-nodes-exchanging-data) 

    3.1 [Introduction](https://github.com/National-Digital-Twin/federator/tree/doc/ia-360-Federator-ducmentation-exchange-of-data-between-ia-nodes?tab=readme-ov-file#introduction)

    3.2 [Overview of approach to IA Nodes exchanging data](https://github.com/National-Digital-Twin/federator/tree/doc/ia-360-Federator-ducmentation-exchange-of-data-between-ia-nodes?tab=readme-ov-file#overview-of-approach-to-ia-nodes-exchanging-data)

    3.3 [Producer configuration](https://github.com/National-Digital-Twin/federator/tree/doc/ia-360-Federator-ducmentation-exchange-of-data-between-ia-nodes?tab=readme-ov-file#server-producer)

	3.4 [Consumer configuration](https://github.com/National-Digital-Twin/federator/tree/doc/ia-360-Federator-ducmentation-exchange-of-data-between-ia-nodes?tab=readme-ov-file#client-consumer)

	3.5 [Consumer & producer authentication](https://github.com/National-Digital-Twin/federator/blob/doc/ia-360-Federator-ducmentation-exchange-of-data-between-ia-nodes/docs/authentication.md#authentication-configuration)
 
4. [Getting data out of an IA node](https://github.com/National-Digital-Twin/graphql-jena/blob/pre/docs/schemas.md#ianode) 

    4.1	[Introduction](https://github.com/National-Digital-Twin/graphql-jena/blob/pre/docs/schemas.md#graphql-for-jena-schemas)

    4.2	[Data extraction API](https://github.com/National-Digital-Twin/graphql-jena?tab=readme-ov-file#graphql-extensions-for-apache-jena)

    4.3	[IA Node Access Control API](https://github.com/National-Digital-Twin/ianode-access?tab=readme-ov-file#integrating-with-other-ianode-applications)

    4.4	[Data extraction tool](https://github.com/National-Digital-Twin/data-extractor?tab=readme-ov-file#data-extractor)
 
5. [Building and deploying IA Node](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/Deployment.md#deployment) 

    5.1	[Introduction](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/Deployment.md#deployment)

	5.2 [Running an IA Node locally](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/DeploymentLocal.md#running-an-ianode-locally)

    5.3 [Creating an IA Node development environment in AWS](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/DeploymentAWS.md#deploy-to-aws)

    5.4 [Deploying an IA Node to AWS](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/DeploymentAWS.md#deploy-to-aws)

    5.5 [Testing IA Node scaling](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Scaling.md#testing-coverage)
 
6. [Platform Architecture](https://github.com/National-Digital-Twin/integration-architecture/blob/main/README.md#cloudplatform-sample-design-and-iac-implementation)

    6.1	[Introduction](https://github.com/National-Digital-Twin/integration-architecture/tree/main/CloudPlatform/AWS#cloudplatformaws)

    6.2	[AWS Development Environment Overview](https://github.com/National-Digital-Twin/integration-architecture/blob/main/CloudPlatform/AWS/README.md)

    6.3	[Building IA Node pipeline](https://github.com/National-Digital-Twin/secure-agents-lib/blob/pre/README.md#secure-agents-lib-java)

    6.4 [Testing IA Node AWS Pipeline Integration](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/DeploymentAWS.md#deploy-to-aws)

    6.5	[Docker Image to EC2](https://github.com/National-Digital-Twin/aws-integration-testing/blob/main/README.md#build-tag-push-docker-image-to-ecr)

    6.6	[Container registry and deployment](https://github.com/National-Digital-Twin/aws-integration-testing/blob/main/README.md#curl-local-container)

    6.7	[Deploying to EC2 instance](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/DeploymentAWS.md#deploying-to-a-ec2-instance)

    6.8	[Deploying to Kubernetes](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/DeploymentAWS.md#deploying-to-kubernetes)

    [Glossary](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/glossary.md)

# APPENDIX
## IA Node Repositories
Here is a list of repositories related to the IA Node that you will find useful for setting up your IA Node.
 |   Repository         |     Description                        | Additional Information | 
|------------|-----------------------------|---------|
| [aws-integration-testing](https://github.com/National-Digital-Twin/aws-integration-testing)    |      Contains the codebase for testing the integration between AWS and GitHub.                 |      -   |        |             |
|            [data-extractor](https://github.com/National-Digital-Twin/data-extractor)| Contains the codebase for data extrator which is a script that can query IA node and upload the resultant data to an AWS S3 bucket.               | -     |        |
|            [federator](https://github.com/National-Digital-Twin/federator)| Contains the codebase for the federator service which allows data exchange between Integration Architecture Nodes.                | -    |        |
|            [fuseki-yaml-config](https://github.com/National-Digital-Twin/fuseki-yaml-config)| Contains the codebase for a tool for translating Yaml files to standard Fuseki config files - consists of a Yaml parser and RDF generator.               | -     |        |
|            [graphql-jena](https://github.com/National-Digital-Twin/graphql-jena)| Contains the codebase for an Apache Jena extension that provides GraphQL query capabilities.               | -    |        |
|            [ianode-access](https://github.com/National-Digital-Twin/ianode-access)| Contains the codebase for IA Node APIs and services for mapping identity to user attributes for ABAC (Attribute Based Access Control) purposes.               | -     |        |
|            [integration-architecture](https://github.com/National-Digital-Twin/integration-architecture)| This repository contains Integration Architecture comprising of IANodes, associated tools and their interactions. It represents the overall product - which has parts within in other repositories listed here.               | It also contains workflows to deploy kubenetes objects that make up an IANode into AWS EKS (kubernetes cluster) using Kustomize.    |        |
|            [jena-fuseki-kafka](https://github.com/National-Digital-Twin/jena-fuseki-kafka)| Provides integration with Kafka streams. This allows RDF (Resource Description Framework) data to received and manipulated via messages on the Kafta streams.               | -     |        |
|            [jwt-servlet-auth](https://github.com/National-Digital-Twin/jwt-servlet-auth)| This repository contains a set of libraries that allows the addition of JSON Web Token (JWT) Bearer authentication into Java Servlet applications.               | -     |        |
|            [label-builder](https://github.com/National-Digital-Twin/label-builder)| This repository contains supports for adding labels for ABAC (Attribute Based Access Control) use on RDF (Resource Description Framework) data via a REST API.               | -     |        |
|            [label-builder-service](https://github.com/National-Digital-Twin/label-builder-service)| This repository contains a web service for adding a “security label” to knowledge model for ABAC (Attribute Based Access Control) purposes.               | label-builder-service integrates with label-builder to allow wrapping a model in a rest-api.   |        |
|            [node-lib](https://github.com/National-Digital-Twin/node-lib)| This repository contains helper libraries for building adaptors, mappers and projectors.               | -     |        |
|            [rdf-abac](https://github.com/National-Digital-Twin/rdf-abac)| This repository contains the codebase that provides the mechanism for fine-grained ABAC (Attribute Based Access Control) to RDF (Resource Description Framework) data as a plug-in for use by secure-agent-graph.             | -     |        |
|            [rdf-abac-evaluator](https://github.com/National-Digital-Twin/rdf-abac-evaluator)| This repository contains the codebase that provides a REST service encompassing the RDF (Resource Description Framework) ABAC (Attribute Based Access Control) label evaluation service.              | The evaluator calls the Access Service to retrieve user and hierarchy information, which is cached in an age-off manner. It then makes use of the 'rdf-abac evaluator' to establish whether the given request evaluates to true or false.    |        |
|            [rdf-libraries](https://github.com/National-Digital-Twin/rdf-libraries)| This repository contains the codebase for libraries that provides 3 services -   Catalog service, Ontology service, and RDF service.              | **1. Catalog service:** Support for working with DCAT data. **2. Ontology service:** Support for working with RDF ontologies and includes CRUD abilities and functions to help navigate an ontology hierarchy. **3. RDF service:** A helper library that abstracts away the complexity of interacting with RDF triplestores and provides CRUD abilities     |        |
|            [secure-agent-entity-resolution](https://github.com/National-Digital-Twin/secure-agent-entity-resolution)| This repository contains codebase that supports the management and analysis of data that links related records, removes duplication and highlights similar entities.             | This agent helps to pair and link records in the dataset with real-world things such as people, organisations and addresses with the aim of increasing accuracy and reliability.     |        |
|            [secure-agent-graph](https://github.com/National-Digital-Twin/secure-agent-graph)| This repository contains the codebase that provides the libraries and mechanism for receiving and holding RDF (Resource Description Framework) data. It also provides SPARQL access and integration points such as with ABAC components for security and control over data access.               | It makes use of Apache Jena and includes support for integration with Kafka. These are libraries for building Secure Agent implementations in Java. It also contains an API for defining pipelines as well as admin oriented APIs for invoking and running pipelines and API servers.    |        |
|            [secure-agents-lib](https://github.com/National-Digital-Twin/secure-agents-lib)| This repository contains libraries intended for rapid Secure Agents implementations in Java.               | It provides a lightweight functional API for defining pipelines as well as more admin/operations oriented APIs for invoking and running Secure Agents pipelines and API Servers.      |        |

