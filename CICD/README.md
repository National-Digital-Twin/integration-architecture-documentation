# CICD
This directory contains continuous integration & continuous delivery resources for deploying an IANode.

## CICD/overlay
This directory contains environmental variables required to deploy IANode resources into an AWS environment. Kustomize is used for orchestrating kubernetes resources. 

## CICD/resources
The folloing sub-directories contain kubernetes resources which make up an IANode.
- namespace
- secure-agent-graph
- ianode-access
- federator-server
- federator-client
