# Build and run an IANode locally

## Pre-requisites

* AWS CLI
* Docker (running)
* HTTP client e.g. curl, Postman

## Minimal IANode

### Clone Repositories

Fetch source code (Ensure Docker is running as some of the tests use it)
```
git clone https://github.com/National-Digital-Twin/integration-architecture.git
git clone https://github.com/National-Digital-Twin/ianode-access
cd ..
git clone https://github.com/National-Digital-Twin/rdf-abac
cd rdf-abac
mvn clean install
cd ..
git clone https://github.com/National-Digital-Twin/jwt-servlet-auth
cd jwt-servlet-auth
mvn clean install
git clone https://github.com/National-Digital-Twin/secure-agents-lib.git
cd secure-agents-lib
mvn clean install
cd ..
git clone https://github.com/National-Digital-Twin/jena-fuseki-kafka
cd jena-fuseki-kafka
mvn clean install
cd ..
git clone https://github.com/National-Digital-Twin/graphql-jena
cd graphql-jena
mvn clean install -Dmaven.javadoc.skip=true
cd ..
git clone https://github.com/National-Digital-Twin/fuseki-yaml-config
cd fuseki-yaml-config
mvn clean install
cd ..
git clone https://github.com/National-Digital-Twin/secure-agent-graph.git
cd secure-agent-graph
mvn clean install
```
### Move Docker Compose and Configuration Files to the Root Directory

After cloning the repositories, move the following files and directories from the ```integration-architecture/docker-compose``` folder to your root directory (National-Digital-Twin). This step consolidates all necessary Docker configuration files in one place and simplifies relative path references.

```
integration-architecture/docker-compose/docker-compose.yml
integration-architecture/docker-compose/init-mongo.sh
integration-architecture/docker-compose/cognito
integration-architecture/docker-compose/cognito-backup
```

### Start up IANode using Integration Architecture
```
cd National-Digital-Twin
docker compose up
```
Wait for terminal window to download and install the required packages, and then start up.
Leave the terminal window running. The accounts will be created and added to user groups.

You can view more details about each container in your Docker Hub.

Check it's running and account is in place
```
aws --endpoint http://0.0.0.0:9229 cognito-idp initiate-auth --client-id 6967e8jkb0oqcm9brjkrbcrhj --auth-flow USER_PASSWORD_AUTH --auth-parameters USERNAME=test+admin@ndtp.co.uk,PASSWORD=password
```
and note the token id from the output (This will be required to test access control)

```
curl -H "Authorization: bearer <id token>" http://localhost:8091/whoami
```
and some details about that user should be shown.

### Run access control test

Try to upload file, should fail as unauthenticated
```
curl -XPOST -T <path-to>/secure-agent-graph/sag-docker/Test/data1.trig --header "Content-type: text/trig" http://localhost:3030/ds/upload
```

Obtain token and try again (replace id token placeholder in second step). This should show person4321 and phone number ending 333.
```
aws --endpoint http://0.0.0.0:9229 cognito-idp initiate-auth --client-id 6967e8jkb0oqcm9brjkrbcrhj --auth-flow USER_PASSWORD_AUTH --auth-parameters USERNAME=test+user+admin@ndtp.co.uk,PASSWORD=password
curl -XPOST -T <path-to>/secure-agent-graph/sag-docker/Test/data1.trig --header "Content-type: text/trig" -H "Authorization: bearer <id token from previous step>" http://localhost:3030/ds/upload
curl -X POST -H "Authorization: bearer <id token from previous step>" -d "query=select ?s ?p ?o where { ?s ?p ?o . }" http://localhost:3030/ds
```

Obtain token for second user and fetch data. This should show person4321 with number ending 333 and person9876 with a empId value and no phone number.
```
aws --endpoint http://0.0.0.0:9229 cognito-idp initiate-auth --client-id 6967e8jkb0oqcm9brjkrbcrhj --auth-flow USER_PASSWORD_AUTH --auth-parameters USERNAME=test+user@ndtp.co.uk,PASSWORD=password
curl -X POST -H "Authorization: bearer <id token from previous step>" -d "query=select ?s ?p ?o where { ?s ?p ?o . }" http://localhost:3030/ds
```

Run a GraphQL query
```
curl -XPOST  -H "Authorization: bearer <id token from previous step>" -H "Content-Type: application/json" --data '{"query": "query { node(uri: \"http://example/person4321\") {id properties { predicate value }} }" }' http://localhost:3030/ds/graphql
```
should output ```{"data":{"node":{"id":"http://example/person4321","properties":[{"predicate":"http://example/phone","value":"0400 111 333"}]}}}```