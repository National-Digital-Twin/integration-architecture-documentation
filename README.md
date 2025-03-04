# Getting Started
## Outlines what you can expect with IA Node.
Getting Started will guide you through the different repositories and the process of integrating, configuring and using an IA Node. It will help you with understanding and getting started with spinning up your own IA Node. 

The table of content below is organised in such a way to help you get to the relevant information and repository you need to get you started with your IA Node.

## 1. IA Node Background

    1.1	[Introduction](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IANode/IANode.md#ianode)

    1.2 [Overview of IA Node](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IntegrationArchitecture.md#integration-architecture) 

	1.3 [Key functional components](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IANode/Components.md#key-functional-components-of-an-ia-node) 

    1.4 [IA Node features](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IANode/Features.md#ianode-features)

	1.5 [How IA Nodes work together in a wider network](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/NodeNet.md#nodenet)

    1.6 [Management Node](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/ManagementNode.md#managementnode)

	1.7 [Code repositories](#ia-node-repositories)

## 2. Ingesting data into an IA Node

    2.1 [Introduction](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IANode/DataIngestion.md#data-ingestion-into-the-integration-architecture-node-ia-node)

    2.2 [Data ingestion approaches](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IANode/DataIngestion.md#data-ingestion-methods)

## 3. Exchanging Data between IA Nodes

    3.1 [Introduction](https://github.com/National-Digital-Twin/federator/blob/main/README.md#introduction)

    3.2 [Overview of approach to data exchange between IA Nodes](https://github.com/National-Digital-Twin/federator/blob/main/README.md#overview-of-approach-to-ia-nodes-exchanging-data)

    3.3 [Producer server configuration]([https://github.com/National-Digital-Twin/federator/blob/main/README.md#server-producer](https://github.com/National-Digital-Twin/federator/blob/main/docs/server-configuration.md#server-configuration))

	3.4 [Consumer server configuration](/docs/server-configuration.md#server-configuration)

	3.5 [Consumer & producer authentication](https://github.com/National-Digital-Twin/federator/blob/main/docs/authentication.md#authentication-configuration)
 
## 4. Data extraction from an IA Node

    4.1	[Introduction](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IANode/DataExtraction.md#data-extraction-from-the-integration-architecture-node-ia-node)

     4.2	[IA Node Access](https://github.com/National-Digital-Twin/ianode-access/blob/pre/README.md#ianode-access)

    4.3	[Data extractor](https://github.com/National-Digital-Twin/data-extractor/blob/main/README.md#data-extractor)
 
## 5. Building and deploying IA Node

    5.1	[Introduction](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/Deployment.md#deployment)

	5.2 [Running an IA Node locally](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/DeploymentLocal.md#running-an-ianode-locally)

    5.3 [Deploy to AWS](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/DeploymentAWS.md#deploy-to-aws)

    5.4 [Run basic test for minimal IA Node functionality](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/DeploymentLocal.md#run-basic-test-for-minimal-ianode-functionality)
 
## 6. Platform Architecture

    6.1	[Introduction](https://github.com/National-Digital-Twin/integration-architecture/tree/main/CloudPlatform/AWS#cloudplatformaws)

    6.2	[Overview on AWS development environment](https://github.com/National-Digital-Twin/integration-architecture/blob/main/CloudPlatform/AWS/README.md)

    6.3	[Building IA Node pipeline](https://github.com/National-Digital-Twin/secure-agents-lib/blob/pre/README.md#secure-agents-lib-java)

    6.4 [Testing IA Node AWS pipeline integration](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/DeploymentAWS.md#deploy-to-aws)

    6.5	[Docker image to EC2](https://github.com/National-Digital-Twin/aws-integration-testing/blob/main/README.md#build-tag-push-docker-image-to-ecr)

    6.6	[Container registry and deployment](https://github.com/National-Digital-Twin/aws-integration-testing/blob/main/README.md#curl-local-container)

    6.7	[Deploying to EC2 instance](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/DeploymentAWS.md#deploying-to-a-ec2-instance)

    6.8	[Deploying to Kubernetes](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/Deployment/DeploymentAWS.md#deploying-to-kubernetes)

# APPENDICES

## Glossary
[Glossary of terms, definitions and abbreviations](https://github.com/National-Digital-Twin/integration-architecture-documentation/blob/main/DeveloperDocumentation/IANode/Glossary.md#glossary)

## IA Node Repositories
Here is a list of repositories you will find useful for setting up your own IA Node.
 |   Repository         |     Description                        | Additional Information | 
|------------|-----------------------------|---------|
| [aws-integration-testing](https://github.com/National-Digital-Twin/aws-integration-testing)    |      This repository contains the codebase for testing integration between AWS and GitHub.                 |      -   |        |             |
|            [data-extractor](https://github.com/National-Digital-Twin/data-extractor)| This repository contains the codebase for data extrator which is a script that can query IA Node and upload the resultant data to an AWS S3 bucket.               | -     |        |
|            [federator](https://github.com/National-Digital-Twin/federator)| This repository contains the codebase for the federator service which allows data exchange between Integration Architecture Nodes.                | -    |        |
|            [fuseki-yaml-config](https://github.com/National-Digital-Twin/fuseki-yaml-config)| This repository contains the codebase for a tool for translating Yaml files to standard Fuseki config files - consists of a Yaml parser and RDF generator.               | -     |        |
|            [graphql-jena](https://github.com/National-Digital-Twin/graphql-jena)| This repository contains the codebase for an Apache Jena extension that provides GraphQL query capabilities.               | -    |        |
|            [ianode-access](https://github.com/National-Digital-Twin/ianode-access)| This repository contains the codebase for IA Node APIs and services for mapping identity to user attributes for ABAC (Attribute Based Access Control) purposes.               | -     |        |
|            [integration-architecture](https://github.com/National-Digital-Twin/integration-architecture)| This repository contains Integration Architecture comprising of IANodes, associated tools and their interactions. It represents the overall product - stored within the other repositories listed here.               | Workflows for deploying container images into an AWS EKS (kubernetes cluster) using Kustomize can also be found within this repository.   |        |
|            [jena-fuseki-kafka](https://github.com/National-Digital-Twin/jena-fuseki-kafka)| Provides integration with Kafka streams. This allows RDF (Resource Description Framework) data to be received and manipulated via messages on the Kafta streams.               | -     |        |
|            [jwt-servlet-auth](https://github.com/National-Digital-Twin/jwt-servlet-auth)| This repository contains a set of libraries that allows the addition of JSON Web Token (JWT) Bearer authentication into Java Servlet applications.               | -     |        |
|            [label-builder](https://github.com/National-Digital-Twin/label-builder)| This repository contains supports for adding labels for ABAC (Attribute Based Access Control) use on RDF (Resource Description Framework) data via a REST API.               | -     |        |
|            [label-builder-service](https://github.com/National-Digital-Twin/label-builder-service)| This repository contains a web service for adding a 'security label' to knowledge model for ABAC (Attribute Based Access Control) purposes.               | label-builder-service integrates with label-builder to allow wrapping a model in a rest-api.   |        |
|            [node-lib](https://github.com/National-Digital-Twin/node-lib)| This repository contains helper libraries for building adaptors, mappers and projectors.               | -     |        |
|            [rdf-abac](https://github.com/National-Digital-Twin/rdf-abac)| This repository contains the codebase that provides the mechanism for fine-grained ABAC (Attribute Based Access Control) to RDF (Resource Description Framework) data as a plug-in for use by secure-agent-graph.             | -     |        |
|            [rdf-abac-evaluator](https://github.com/National-Digital-Twin/rdf-abac-evaluator)| This repository contains the codebase that provides a REST service encompassing the RDF (Resource Description Framework) ABAC (Attribute Based Access Control) label evaluation service.              | The evaluator calls the Access Service to retrieve user and hierarchy information, which is cached in an age-off manner. It then makes use of the 'rdf-abac evaluator' to establish whether the given request evaluates to true or false.    |        |
|            [rdf-libraries](https://github.com/National-Digital-Twin/rdf-libraries)| This repository contains the codebase for libraries that provides 3 services -   Catalog service, Ontology service, and RDF service.              | **1. Catalog service:** Support for working with DCAT data. **2. Ontology service:** Support for working with RDF ontologies and includes CRUD abilities and functions to help navigate an ontology hierarchy. **3. RDF service:** A helper library that abstracts away the complexity of interacting with RDF triplestores and provides CRUD abilities     |        |
|            [secure-agent-entity-resolution](https://github.com/National-Digital-Twin/secure-agent-entity-resolution)| This repository contains codebase that supports the management and analysis of data that links related records, removes duplication and highlights similar entities.             | This agent helps to pair and link records in the dataset with real-world things such as people, organisations and addresses with the aim of increasing accuracy and reliability.     |        |
|            [secure-agent-graph](https://github.com/National-Digital-Twin/secure-agent-graph)| This repository contains the codebase that provides the libraries and mechanism for receiving and holding RDF (Resource Description Framework) data. It also provides SPARQL access and integration points such as with ABAC components for security and control over data access.               | It makes use of Apache Jena and includes support for integration with Kafka. These are libraries for building Secure Agent implementations in Java. It also contains an API for defining pipelines as well as admin oriented APIs for invoking and running pipelines and API servers.    |        |
|            [secure-agents-lib](https://github.com/National-Digital-Twin/secure-agents-lib)| This repository contains libraries intended for rapid Secure Agents implementations in Java.               | It provides a lightweight functional API for defining pipelines as well as more admin/operations oriented APIs for invoking and running Secure Agents pipelines and API Servers.      |        |

