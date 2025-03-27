# IA Node in action
**Repository:** integration-architecture-documentation 

**Description:** This file contains documentation about data ingestion sequence and logical data flow of Integration Architecture Node (IA Node). 

<!-- SPDX-License-Identifier: OGL-UK-3.0 -->

## Data ingest pipeline sequence
```mermaid
sequenceDiagram
    box Lib Platform
        participant D as "Data Pipeline"
        participant K as "Knowledge"
    end
    box Secure Agent Graph
        participant J as "Jena Fuseki Module"
        participant I as "Jena TDB"
        participant L as "Label Store"
    end
    D->>K: Produces Events
    loop Continuously
      activate J
      J ->>+K : "Polls for Knowledge Events"
      K ->>-J : "Returns Knowledge Events"
    end
    par "RDF Triple Processing"
      J ->> J: "Extract RDF"
      J ->>+I : "Insert into Triple Store"
    and "Security Label Processing"
      J ->> J: "Extract Security Label"
      J ->> L: "Insert into Label Store"
    end
    I ->>-J : Returns Status
    deactivate J

```

## Logical flow

```mermaid
flowchart
    subgraph User
        authenticatedUser[Authenticated User]
    end
    subgraph Lib platform
        subgraph Secure Agent Graph
            subgraph API
                sparqlUpdate[SPARQL Update]
                graphQLRequest[GraphQL Request]
                sparqlRequest[SPARQL Request]
            end
            cqrsModule[CQRS Module]
            eventImporter[Event Importer]
            apacheJena[(Apache Jena)]
            ABAC
            labelStore[(Label store)]
            fusekiServer[Fuseki server]
        end
        subgraph Event log
            Knowledge
        end
        subgraph Identity services
            userAttributesService[User Attributes Service]
        end
    end

    User --> sparqlUpdate
    User --> graphQLRequest
    User --> sparqlRequest
    sparqlUpdate --> cqrsModule
    cqrsModule --> Knowledge
    Knowledge --> eventImporter
    eventImport --> apacheJena
    apacheJena --> ABAC
    ABAC --> labelStore
    ABAC --> fusekiServer
    fusekiServer --> userAttributesService
    graphQLRequest --> fusekiServer
    sparqlRequest --> fusekiServer
```

© Crown Copyright 2025. This work has been developed by the National Digital Twin Programme and is legally attributed to the Department for Business and Trade (UK) as the governing entity.  
Licensed under the Open Government Licence v3.0.  

You can view the full license at:  
https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/
