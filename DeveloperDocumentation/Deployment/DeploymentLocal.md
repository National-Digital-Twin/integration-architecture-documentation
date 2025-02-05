# Running an IANode locally

## Pre-requisites

* AWS CLI
* Docker (running)
* Postman/Curl
* Git cli

## Start up identity provider and access control
```
docker compose up mongo
```
(and leave that running)

Fetch source code
```
git clone https://github.com/National-Digital-Twin/ianode-access
```

Start up cognito emulator
```
cd ianode-access/cognito-local
docker compose up
```
Wait for terminal window to say "Cognito Local running on http://0.0.0.0:9229"
(and leave that running)

Prepare accounts in emulator
```
sh reset_cognito.sh
sh config_cognito.sh
```
Wait for script to complete and window to say "Added users to groups when required".

Start up identity provider emulator
```
cd ..
. ./token_env.sh [Sets some environment variables for local running with tokens]
export SCIM_ENABLED=true [So that cognito-local is used]
npm install
DEPLOYED_DOMAIN="http://localhost:3000" yarn dev [Run server providing API]
```
(leave that running)

Check it's running and account is in place
```
aws --endpoint http://0.0.0.0:9229 cognito-idp initiate-auth --client-id 6967e8jkb0oqcm9brjkrbcrhj --auth-flow USER_PASSWORD_AUTH --auth-parameters USERNAME=test+admin@ndtia.dbt.gov.uk,PASSWORD=password
```
and note the token id from the output
```
curl -H "Authorization: bearer <id token>" http://localhost:8091/whoami
```
and some details about that user should be shown.

```
cd ianode-access/cognito-local
sh config_cognito.sh
```
This creates access details for test+admin@ndtp.co.uk, test+user@ndtp.co.uk, test+user+admin@ndtp.co.uk and test@ndtp.co.uk.

Run API

```
cd ..
scripts/dev-docker-setup.sh
```

## Prepare authentication for fetching GitHub packages
https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-apache-maven-registry#authenticating-to-github-packages

## Fetch source code and build packages
```
git clone https://github.com/National-Digital-Twin/rdf-abac
cd rdf-abac
mvn clean install
cd ..
git clone https://github.com/National-Digital-Twin/secure-agents-core.git
cd secure-agents-core
(Ensure Docker is running as the tests use it)
mvn clean install -Dlicense.skip=true
cd ..
git clone https://github.com/National-Digital-Twin/jena-fuseki-kafka
cd jena-fuseki-kafka
mvn clean install
cd ..
git clone https://github.com/National-Digital-Twin/graphql-jena
mvn clean install
cd ..
git clone https://github.com/National-Digital-Twin/fuseki-yaml-config
mvn clean install
cd ..
git clone https://github.com/National-Digital-Twin/secure-agent-graph.git
cd secure-agent-graph
mvn clean install
```

## Start up secure-agent-graph

Start in-memory secure agent graph with dev config TODO Indicate anything different for production in config file
```
sag-docker/docker-run.sh --config config/dev-server-sag.ttl
```

## Run basic test for minimal IANode functionality

Upload knowledge and fetch data
```
curl -XPOST -T /Users/martin.willitts/Projects/NDTP/IA/secure-agent-graph/sag-docker/Test/data1.trig --header "Content-type: text/trig" http://localhost:3030/ds/upload
curl http://localhost:3030/ds # Fetches both records
```

Check local JWKS keys accessible
```
curl http://localhost:9229/local_6GLuhxhD/.well-known/jwks.json # Should output data
```

## Run access control test

Adjust sag-docker/docker-run.sh
* Change value for JWKS_URL from 'disabled' to ```http://localhost:9229/local_6GLuhxhD```
* Add USER_ATTRIBUTES_URL ``` -e USER_ATTRIBUTES_URL="http://host.docker.internal:8091" \```
* Restart docker container
```
sag-docker/docker-run.sh --config config/config-abac-local.ttl
```

Try to upload file, should fail as unauthenticated
```
curl -XPOST -T /Users/martin.willitts/Projects/NDTP/IA/secure-agent-graph/sag-docker/Test/data1.trig --header "Content-type: text/trig" http://localhost:3030/ds/upload
```

Obtain token and try again (replace id token placeholder in second step). This should show person4321 and phone number ending 333.
```
aws --endpoint http://0.0.0.0:9229 cognito-idp initiate-auth --client-id 6967e8jkb0oqcm9brjkrbcrhj --auth-flow USER_PASSWORD_AUTH --auth-parameters USERNAME=test+user+admin@ndtp.co.uk,PASSWORD=password
curl -XPOST -T /Users/martin.willitts/Projects/NDTP/IA/secure-agent-graph/sag-docker/Test/data1.trig --header "Content-type: text/trig" -H "Authorization: bearer <id token from previous step>" http://localhost:3030/ds/upload
curl -X POST -H "Authorization: bearer <id token from previous step>" -d "query=select ?s ?p ?o where { ?s ?p ?o . }" http://localhost:3030/ds
```

Obtain token for second user and fetch data. This should show person4321 with number ending 333 and person9876 with a empId value and no phone number.
```
aws --endpoint http://0.0.0.0:9229 cognito-idp initiate-auth --client-id 6967e8jkb0oqcm9brjkrbcrhj --auth-flow USER_PASSWORD_AUTH --auth-parameters USERNAME=test+user@ndtp.co.uk,PASSWORD=password
curl -X POST -H "Authorization: bearer <id token from previous step> " -d "query=select ?s ?p ?o where { ?s ?p ?o . }" http://localhost:3030/ds
```

Run a GraphQL query
```
curl -XPOST  -H "Authorization: bearer <id token from previous step>" -H "Content-Type: application/json" --data '{"query": "query { node(uri: \"http://example/person4321\") {id properties { predicate value }} }" }' http://localhost:3030/ds/graphql
```
should output ```{"data":{"node":{"id":"http://example/person4321","properties":[{"predicate":"http://example/phone","value":"0400 111 333"}]}}}```