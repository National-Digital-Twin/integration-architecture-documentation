# Scaling

**Repository:** `integration-architecture-documentation`  
**Description:** `This file provides documentation on scaling Integration Architecture Node (IA Node). `  
<!-- SPDX-License-Identifier: OGL-UK-3.0 -->

## Testing coverage
Testing of the source code covers the [IA Node capabilities](IANode/IANode.md#capabilities) and the following level of scale:

* File upload into an IA Node
* Maximum file size of 20MB
* Load time of under 1 minute (with some level of mapping included TBD)
* Kafka messages
* Maximum of 10,000 initial load
* Messages processed at up to 10 per second (with some level of mapping included TBD)
* Message body size of up to 100KB
* Query (SPARQL and GraphQL)
* Maximum of 3 knowledge bases accessed by one query
* Result set of 100 items and up to 10MB in total
* Results returned within 1 minute for local node knowledge (with some level of fine-grained control and some level of redaction in place TBD)
* Multiple nodes
* One IA Node receiving data from up to 10 other nodes and sending out to up to 10 other nodes (with fine-grained access controls in use TBD)
* Results available within 30 minutes for knowledge collected from up to 10 other nodes (with some level of mapping and complexity TBD)

© Crown Copyright 2025. This work has been developed by the National Digital Twin Programme and is legally attributed to the Department for Business and Trade (UK) as the governing entity.  

Licensed under the Open Government Licence v3.0.  
