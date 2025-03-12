# Node Net
## Outlines the concept and composition of a Node Network (Node Net). 
A Node Net is a network composed of multiple [IA nodes](IANode/ia-node.md) (and typically a Management Node) working together. It is a network that can be deployed by any organisation or consortium to address specific digital twin or data needs or services. The Management Node within a Node net handles its lifecycle tasks and ensures alignment with both local and national requirements.

Also known as N2.

```mermaid
flowchart TD
  N2[NodeNet N2] <--> IANode1[IANode 1]
  N2[NodeNet N2] <--> IANode2[IANode 2]
  N2[NodeNet N2] <--> IANode3[IANode 3]
  N2[NodeNet N2] <--> IANode More[...]
```
