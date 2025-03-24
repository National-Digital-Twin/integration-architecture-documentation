# Deploy to Azure

```mermaid
flowchart
  azureAD[Azure AD]
  subgraph ???
      subgraph Kubernetes
          subgraph Docker
              IANode
              Mongo
          end
      end
  end
```
