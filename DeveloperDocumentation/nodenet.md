# NodeNet
A NodeNet is a network composed of multiple [IANode](IANode/IANode.md)s (and typically a ManagementNode) working together. A NodeNet can be deployed by any organisation or consortium to address specific digital twin or data needs or services. The ManagementNode within a NodeNet handles its lifecycle tasks and ensures alignment with both local and national requirements.

Also known as N2.

```mermaid
flowchart TD
  N2[NodeNet N2] <--> IANode1[IANode 1]
  N2[NodeNet N2] <--> IANode2[IANode 2]
  N2[NodeNet N2] <--> IANode3[IANode 3]
  N2[NodeNet N2] <--> IANodeMore[...]
```
