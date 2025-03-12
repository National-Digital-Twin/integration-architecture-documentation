# Integration Architecture Overview
## Provides you with an integration architecture overview, developer perspective and the different integration architecture levels.
The Integration Architecture is the overarching framework that defines how different nodes ([IA Node](IANode/ia-node.md) and [Management Node](management-node.md)), [Node Net](node-net.md), and ultimately the National Digital Twin interoperate. It lays out the principles, standards, and technical guidelines governing data sharing, security, and interoperability across all nodes and networks.

## Developer perspective
From the perspective of a developer, the idea is to support a network of nodes where each node is deployed in some cloud environment with security wrapped around it. Each node provides a "backend" for interaction with Digital Twin data. That data is a set of RDF triples. Furthermore, a query sent to one [IANode](IANode/ia-node.md) may involve support from several other [IA nodes](IANode/ia-node.md) managed by other organisations. The software is provided by the NDTP in order for organisations to configure and operate their own [IA nodes](ia-node/ia-node.md) and [Node nets](node-net.md).

## Integration Architecture Levels
An [IA Node](IANode/ia-node.md) can be run in many ways and can be part of a Node net collection of [IA nodes](IANode/ia-node.md). The levels are a way of understanding what is available with each level building on the previous. An instance of an [IA Node](IANode/ia-node.md) can be run at each level.

* Level 0 – Development environment running [IA Node](IANode/ia-node.md) components
* Level 1 – Ability to deploy, run and query a single [IA Node](IANode/ia-node.md) to both AWS and Azure
* Level 2 – Ability to deploy, run and query [IA Node](IANode/ia-node.md) that accesses multiple other [IA nodes](IANode/ia-node.md) for data
* Level 3 – Integrated delivery solution supporting change management across multiple parties from change request to published updates

### Level 0
This is running an [IA Node](IANode/ia-node.md) on a developer's computer:
- 1 x Minimal IA node 
- 1 x Single IA node
- 1 x Distributed IA node

### Level 1
This is running an IA node in cloud environments (AWS and Azure).

### Level 2
This is running multiple IA nodes as a Node net as might be done by a group of separate organisations sharing data with:
- 2 x IA nodes in AWS
- 2 x IA nodes in Azure
- Combination of IA nodes in AWS and Azure
- Inclusion of a Management node

### Level 3
This is the tools and environments for the overall product. It includes the tools for external parties to:
- submit and track change requests
- support communication about updates and roadmaps
- view and use live instances
