# Data Extraction Methods
## Outlines the data extraction methods used by IA Node.

### **1. Extracting Data via SPARQL Queries**  

[Secure Agent Graph](https://github.com/National-Digital-Twin/secure-agent-graph) provides a built-in **Apache Jena** server, allowing data retrieval through **SPARQL endpoints** accessible over **HTTP**.  

The Secure Agent Graph `sparql` endpoint follows SPARQL semantics. Detailed documentation can be found in the following resources:
* [Apache Jena Fuseki](https://jena.apache.org/documentation/fuseki2/)
* [SPARQL 1.1 Query](https://www.w3.org/TR/sparql11-query/)
* [SPARQL 1.1 Protocol](http://www.w3.org/TR/sparql11-protocol/)

An example query for Secure Agent Graph running locally:
```
curl -X POST -H "Authorization: Bearer $NDTP_JWT" \
    http://localhost:3030/ds/sparql?format=text \
    -d 'query=SELECT * WHERE { ?s ?p ?o }'
```

If the Secure Agent Graph application is configured to use AWS Cognito, the local environment variable `NDTP_JWT` can be set using the `set_ndtp_variables.sh` script below. This assumes that AWS Cognito contains a User Pool called `ndtp-testing`. The script is usable only if there are no firewall restrictions preventing the retrieval of JWT tokens from AWS Cognito.

***File: set_ndtp_variables.sh***
```
#!/bin/bash
# Set the AWS region (update if needed)
# AWS_REGION=$(aws configure get region)
AWS_REGION=eu-west-2

# Retrieve the User Pool ID for the 'ndtp-testing' user pool
export NDTP_USER_POOL_ID=$(aws cognito-idp list-user-pools --region $AWS_REGION --max-results 10 --query "UserPools[?Name=='ndtp-testing'] | [0]" | jq -r .Id)

# Get the Client ID for the 'ndtp-testing-client'
CLIENT_ID=$(aws cognito-idp list-user-pool-clients --region $AWS_REGION --user-pool-id $NDTP_USER_POOL_ID --query "UserPoolClients[?ClientName=='ndtp-testing-client'] | [0]" | jq -r .ClientId)

# Retrieve the Client Secret
CLIENT_SECRET=$(aws cognito-idp describe-user-pool-client --region $AWS_REGION --user-pool-id $NDTP_USER_POOL_ID --client-id $CLIENT_ID | jq -r .UserPoolClient.ClientSecret)

# Define the user credentials
USER_NAME="user_1.test@ndtp.net"
USER_PASSWORD="your-secure-password"

# Generate the SECRET_HASH required for authentication
SECRET_HASH=$(echo -n "$USER_NAME$CLIENT_ID" | openssl dgst -sha256 -hmac "$CLIENT_SECRET" -binary | openssl enc -base64)

# Request the JWT token using AWS Cognito authentication
export NDTP_JWT=$(aws --endpoint https://cognito-idp.$AWS_REGION.amazonaws.com cognito-idp initiate-auth \
    --client-id $CLIENT_ID --auth-flow USER_PASSWORD_AUTH \
    --auth-parameters "USERNAME=$USER_NAME,PASSWORD=$USER_PASSWORD,SECRET_HASH=$SECRET_HASH" \
    | jq -r .AuthenticationResult.IdToken)

# Retrieve the JWKS URL for token validation
export NDTP_JWKS_URL=$(curl -s https://cognito-idp.$AWS_REGION.amazonaws.com/$NDTP_USER_POOL_ID/.well-known/openid-configuration | jq -r .jwks_uri)

```

The user user_1.test@ndtp.net is defined in the [Terraform user list](../../CloudPlatform/AWS/terraform.tfvars).
Make sure to replace USER_PASSWORD with the correct value before running the script.

When running a Docker container for Secure Agent Graph, the `NDTP_JWKS_URL` variable can be used:
```
docker run -d --rm -p 3030:3030 \
           -v ./scg-docker/mnt/config/:/fuseki/config \
           -v ./scg-docker/mnt/databases/:/fuseki/databases \
           -e JWKS_URL=$NDTP_JWKS_URL \
           -e USER_ATTRIBUTES_URL=http://host.docker.internal:8091 \
           secure-agent-graph:latest --config config/config-abac-local.ttl 
```

If the Secure Agent Graph application is configured using an [AWS Cognito emulator](https://github.com/National-Digital-Twin/ianode-access/tree/main/cognito-local), refer to the [Running an IA Node Locally](../Deployment/DeploymentLocal.md) document for retrieving the JWT token (`aws --endpoint http://0.0.0.0:9229 cognito-idp initiate-auth` call):
```
aws --endpoint http://0.0.0.0:9229 cognito-idp initiate-auth \
    --client-id 6967e8jkb0oqcm9brjkrbcrhj --auth-flow USER_PASSWORD_AUTH \
    --auth-parameters USERNAME=test+admin@ndtp.co.uk,PASSWORD=password
```

For requests to Secure Agent Graph hosted on AWS, replace `localhost` with the appropriate AWS instance URL.

---

### 2. Extracting Data via GraphQL query

For the details of setup of GraphQL endpoint and authorisation instructions, refer to [Running an IA Node Locally](../Deployment/DeploymentLocal.md).
```
curl -X POST -H "Content-Type: application/json" \
    --data '{"query":"query {node(uri: \"http://example/person4321\") {id properties { predicate value }}}"}' \
    http://localhost:3030/ds/graphql
```

### 3. Extracting Data via Tuple Database (TDB) Command-Line Interface (CLI)  

TDB is a native storage component of **Apache Jena** for **RDF (Resource Description Framework)** data, optimized for efficient disk-based indexing and querying.  

For details on setting up **Secure Agent Graph** to work with persistent storage and obtaining the necessary Apache Jena binaries for data extraction (`tdbquery`), refer to the [Data Ingestion](./DataIngestion.md) document.

To query data from a **TDB store**, use the following command:  

```
apache-jena-5.3.0/bin/tdbquery \
   --loc=<path-to>/secure-agent-graph/scg-docker/mnt/databases/knowledge \
   --query='SELECT * WHERE { ?s ?p ?o }'
```  

---

