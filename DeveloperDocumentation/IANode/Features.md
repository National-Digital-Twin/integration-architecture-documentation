# IANode features
These are the features of an IANode along with the flavours as more features are included.

|            |                             | Minimal | Modest | Distributed |
|------------|-----------------------------|---------|--------|-------------|
| Input      |                             |         |        |             |
|            | configuration               | y       |        |
|            | configuration               | y       |
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
|            | Kafka                       |         | y      |

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
  [Pipeline](IANode/Pipeline.md)

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
* TBD
### Redaction
* TBD
### Storage
* Standard Apache Jena in-memory storage of information
* Standard Apache Jena persistent storage called "TDB2" use local file store

## Output
### RDF (for SPARQL queries)
* Responses to SPARQL queries are in RDF format
* Support for pagination
### JSON (for GraphQL queries
* Responses to GraphQL queries are in JSON format
* Support for pagination
### Kafka
* Ability to send out information in response to a query (??) as a message in a Kafka stream

## Aspects

## Deployment
This is about the mechanisms available for deploying software to a cloud environment.
1. Docker
1. CI/CD
1. Kubernetes

## Platform
This is the design and scripts for setting up IANodes in cloud environments.
1. Local (shell script, written instructions)
1. AWS Terraform - scripts to configure an instance in AWS
1. Feature set support
  1. Support for Minimal feature set
  1. Support for Modest feature set
  1. Support for Distributed feature set
1. Scale
  1. Minimal arrangement, single instance of server, no load balancing, no public access
  1. Load balanced, no public access
  1. Load balanced with access by Demonstrator apps across internet
1. Azure - ditto for Azure

## Test instance
This is the existence of instances running in cloud environments and available for testing purposes.
1. Local
1. AWS EC2
1. Cognito
1. Support for Kubernetes
1. Support for Kafka (EKS)
1. Azure
1. AD
1. Support for Kubernetes
1. Support for Kafka

## Automated testing
1. IANode
1. Unit
1. System
1. Load
1. NodeNet
1. IANodes in AWS only
1. IANodes in AWS and Azure

## Developer documentation
1. Platform decided and available
1. Running IANode content
1. Content on running locally
1. Content on running in AWS
1. Content on running in Azure
1. ...

## Management
1. Git repositories private
1. Change request management
1. Git repositories public
1. Governance
1. ...

