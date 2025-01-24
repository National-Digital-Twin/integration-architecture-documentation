# Integration Architecture
The Integration Architecture is the overarching framework that defines how different nodes ([IANode](IANode/IANode.md) and [ManagementNode](ManagementNode.md)), [NodeNet](NodeNet.md)s, and ultimately the National Digital Twin interoperate. It lays out the principles, standards, and technical guidelines governing data sharing, security, and interoperability across all nodes and networks.

## Developer perspective
From the perspective of a developer, the idea is to support a network of nodes where each node is deployed in some cloud environment with security wrapped around it. Each node provides a "backend" for interaction with Digital Twin data. That data is a set of RDF triples. Furthermore, a query sent to one [IANode](IANode/IANode.md) may involve support from several other [IANode](IANode/IANode.md)s managed by other organisations. The software is provided by the NDTP in order for organisations to configure and operate their own [IANode](IANode/IANode.md)s and [NodeNet](NodeNet.md)s.

## Integration Architecture Levels
An [IANode](IANode/IANode.md) can be run in many ways and can be part of a NodeNet collection of [IANode](IANode/IANode.md)s. The levels are a way of understanding what is available with each level building on the previous. An instance of an [IANode](IANode/IANode.md) can be run at each level.

* Level 0 – Development environment running [IANode](IANode/IANode.md) components
* Level 1 – Ability to deploy, run and query a single [IANode](IANode/IANode.md) to both AWS and Azure
* Level 2 – Ability to deploy, run and query [IANode](IANode/IANode.md) that accesses multiple other [IANode](IANode/IANode.md)s for data
* Level 3 – Integrated delivery solution supporting change management across multiple parties from change request to published updates

### Level 0
This is running an [IANode](IANode/IANode.md) on a developer's computer.
1. Minimal IANode 
1. Modest IANode
1. Distributed IANode

### Level 1
This is running an IANode in cloud environments (AWS and Azure).

### Level 2
This is running multiple IANodes as a NodeNet as might be done by a group of separate organisations sharing data.
1. Two IANodes in AWS
1. Two IANodes in Azure
1. Combination of IANodes in AWS and Azure
1. Include ManagementNode

### Level 3
This is the tools and environments for the overall product. It includes the tools for external parties to submit and track change requests; to support communication about updates and roadmap; and ways of seeing and using live instances.