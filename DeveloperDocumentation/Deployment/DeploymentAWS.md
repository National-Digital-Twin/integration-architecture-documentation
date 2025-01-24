# Deploy to AWS

```mermaid
flowchart
  Cognito
  subgraph EC2
      subgraph Kubernetes
          subgraph Docker
              IANode
              Mongo
          end
      end
  end
```