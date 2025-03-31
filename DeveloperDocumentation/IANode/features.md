# IA Node features

**Repository:** `integration-architecture-documentation`  
**Description:** `This file provides documentation on features of Integration Architecture Node (IA Node). `  
<!-- SPDX-License-Identifier: OGL-UK-3.0 -->

## Outlines the features and capability of IA Node.

The features and capability provided by IA Node are listed below:

|            |                             | Minimal | Single | Distributed |
|------------|-----------------------------|---------|--------|-------------|
| Input      |                             |         |        |             |
|            | configuration               | y       |        |
|            | upload file                 | y       |
|            | SPARQL                      | y       |
|            | GraphQL                     | y       |
|            | Kafka                       |         | y      |
| Processing |
|            | validation of input         |         | y      |
|            | logging                     |         | y      |
|            | federated access            |         |        | y           |
|            | dataset access control      | y       |
|            | fine-grained access control | y       |
|            | mapping and transformation  |         | y      |
|            | redaction                   |         | y      |
| Storage    |
|            | In-memory                   | y       |
|            | TDB2 file store             | y       |
| Output     |
|            | RDF (for SPARQL queries)    | y       |
|            | JSON (for GraphQL queries   | y       |

## Input
### Configuration
* ttl file to specify storage mechanism for information and how to map users to access attributes
* federator access to and from other IANodes
### Upload file
* Ability to POST a file to upload information into the IANode
* Access control in place to say which users can carry this out
### SPARQL
* Ability to POST a SPARQL formatted query to fetch data from locally held information
### GraphQL
* Ability to POST a GraphQL formatted query to fetch data from locally held information
### Kafka
* Ability to receive messages from Kafka stream for processing within the IANode

## Processing
### Validation of input
* Rules for validating incoming information from file and from message from Kafka
### Logging
* "stdout" logging of activity in the code with standard levels, debug, info, warning etc
### Federated access
* Ability to send a query to another IANode and receive response
* Ability to receive a query from another IANode and send response
* Support for sending query to multiple IANodes at once
* Support for receiving query from multiple IANodes at once
### Dataset access control
* Handling access to datasets based on attributes held in the JWT and related attribute stores
### Fine-grained access control
* Handling access at individual field level based on JWT attributes
### Mapping and transformation
* Support for mapping and transformation of the data as per the requirements
### Redaction
* Filter the data where labels don't match the user attributes
### Storage
* Standard Apache Jena in-memory storage of information
* Standard Apache Jena persistent storage called "TDB2" use local file store

## Output
### RDF (for SPARQL queries)
* Responses to SPARQL queries are in RDF format
* Support for pagination
### JSON (for GraphQL queries)
* Responses to GraphQL queries are in JSON format
* Support for pagination
### Kafka
* Ability to send out information in response to a query (??) as a message in a Kafka stream

© Crown Copyright 2025. This work has been developed by the National Digital Twin Programme and is legally attributed to the Department for Business and Trade (UK) as the governing entity.  
Licensed under the Open Government Licence v3.0.  
