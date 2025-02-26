
<Based on the comments Stuart made in the teams chat during the meeting on Wednesday 26th Feb>   

# Documentation for the Integration Architecture Project

## Table of Contents

- [Introduction](#introduction)
- [IA Node Background and Context](#ia-node-background-and-context)
    - [Brief history and attributions](#brief-history-and-attributions)
    - [Overview of IA Nodes](#overview-of-ia-nodes)
    - [Describe core functional components](#describe-core-functional-components)
    - [Describe data ingestion and ABAC *](#describe-data-ingestion-and-abac-)
    - [Show how IA Nodes work together in a wider network](#show-how-ia-nodes-work-together-in-a-wider-network)
    - [Code Repositories Overview](#code-repositories-overview)
    - [Known constraints or limitations *](#known-constraints-or-limitations-)
    - [Glossary and Definitions](#glossary-and-definitions)
    - [Roadmap *](#roadmap-)
- [Ingesting Data into an IA Node](#ingesting-data-into-an-ia-node)
    - [Introduction](#introduction-1)
    - [Data ingestion approach – REST API](#data-ingestion-approach--rest-api)
    - [Data ingestion approach - Federators](#data-ingestion-approach---federators)
    - [Data security, labelling and transformation *](#data-security-labelling-and-transformation-)
    - [Exchange of Data between IA Nodes](#exchange-of-data-between-ia-nodes)
    - [Overview of approach to IA Nodes exchanging data](#overview-of-approach-to-ia-nodes-exchanging-data)
    - [Producer configuration](#producer-configuration)
    - [Consumer configuration](#consumer-configuration)
    - [Consumer & producer authentication](#consumer--producer-authentication)
    - [ABAC - Data filtering and redaction *](#abac---data-filtering-and-redaction-)
- [API Documentation](#api-documentation)
    - [GraphQL API - can just point to external resources as needed *](#graphql-api---can-just-point-to-external-resources-as-needed-)
    - [SPARQL API -  can just point to external resources as needed *](#sparql-api---can-just-point-to-
    - [Data Ingestion API](#data-ingestion-api)
    - [Access API](#access-api)
- [CI/CD Pipeline (Nick & Kyle)](#cicd-pipeline-nick--kyle)
    - [Overview](#overview)
    - [How the pipeline works](#how-the-pipeline-works)
    - [Images that get built](#images-that-get-built)
    - [Vulnerability checking](#vulnerability-checking)
    - [Dependabot](#dependabot)
    - [Code smells](#code-smells)
    - [Container registry and deployment](#container-registry-and-deployment)
    - [Deploying to EC2 instance](#deploying-to-ec2-instance)
    - [Deploying to Kubernetes](#deploying-to-kubernetes)
    - [Operational Considerations (Nick and Kyle)](#operational-considerations-nick-and-kyle)
    - [Environment requirements / considerations](#environment-requirements--considerations)
    - [Development environment](#development-environment)
    - [Access to resources via Bastion](#access-to-resources-via-bastion)
    - [Access to S3 bucket](#access-to-s3-bucket)
    - [Access to Cognito](#access-to-cognito)
- [How To Section](#how-to-section)
    - [How to build and unit test an IA Node locally](#how-to-build-and-unit-test-an-ia-node-locally)
    - [How to run an IA Node locally](#how-to-run-an-ia-node-locally)
    - [How to create the exemplar IA Node environment in AWS](#how-to-create-the-exemplar-ia-node-environment-in-aws)
    - [How to deploy an IA Node to AWS](#how-to-deploy-an-ia-node-to-aws)
    - [How to test an IA Node](#how-to-test-an-ia-node)
- [FAQ Section * (Not sure what FAQs are needed, these are just examples or placeholders. Section may not be needed)](#faq-section--not-sure-what-faqs-are-needed-these-are-just-examples-or-placeholders-section-may-not-be-needed)
    - [Can I run more than 2 federators](#can-i-run-more-than-2-federators)
    - [Can I run the IA Node in Azure? x](#can-i-run-the-ia-node-in-azure-x)
    - [Can I use my own Kafka/Redis/Mongo clusters?](#can-i-use-my-own-kakfaredismongo-clusters)



## IA Node Background and Context
### Brief history and attributions
### Overview of IA Nodes
### Describe core functional components
### Describe data ingestion and ABAC *
### Show how IA Nodes work together in a wider network
### Code Repositories Overview
### Known constraints or limitations *
### Glossary and Definitions
### Roadmap *

## Ingesting Data into an IA Node
### Introduction
### Data ingestion approach – REST API
### Data ingestion approach - Federators
### Data security, labelling and transformation *

### Exchange of Data between IA Nodes
### Overview of approach to IA Nodes exchanging data
### Producer configuration
### Consumer configuration
### Consumer & producer authentication
### ABAC - Data filtering and redaction *

## API Documentation
### GraphQL API - can just point to external resources as needed *
### SPARQL API -  can just point to external resources as needed * 
### Data Ingestion API
### Access API

## CI/CD Pipeline (Nick & Kyle)
### Overview
### How the pipeline works
### Images that get built
### Vulnerability checking
### Dependabot
### Code smells
### Container registry and deployment
### Deploying to EC2 instance
### Deploying to Kubernetes
### Operational Considerations (Nick and Kyle)
### Environment requirements / considerations
### Development environment
### Access to resources via Bastion
### Access to S3 bucket
### Access to Cognito
- Anything else?

## How To Section
### How to build and unit test an IA Node locally
### How to run an IA Node locally
### How to create the exemplar IA Node environment in AWS
### How to deploy an IA Node to AWS
### How to test an IA Node

## FAQ Section * (Not sure what FAQs are needed, these are just examples or placeholders. Section may not be needed)
### Can I run more than 2 federators

- yes, but i suspect it would be better to run many servers and many clients inside of one federator service

### Can I run the IA Node in Azure? x
### Can I use my own Kafka/Redis/Mongo clusters?
- etc 
