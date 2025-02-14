# CICD
This directory contains continuous integration, continuous delivery resources for deploying an IANode

# Workflows

## Deploy-to-kube.yml
Workflow which orchestrates kubernetes objects into a private AWS EKS cluster

# CICD/overlay
Directory which contains environmental variables required to deploy an IANode from kubernetes objects into an AWS environment

# CICD/resources
Directorys within contain kubernetes resources which make up an IANode
- namespace
- secure-agent-graph
