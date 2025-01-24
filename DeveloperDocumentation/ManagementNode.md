# ManagementNode
A ManagementNode is a specialised type of [IANode](IANode/IANode.md) responsible for overseeing and managing one or more [NodeNet](NodeNet)s. The ManagementNode ensures that the NodeNet remains compliant with IA principles, handles registration of participating IANodes, and orchestrates updates. Crucially, it also connects to the [NationalNodeNet](NationalNodeNet.md) to receive sector-agnostic updates, while allowing each NodeNet to apply local configurations and updates independently.

