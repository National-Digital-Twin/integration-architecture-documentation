# Running an IA node locally

**Repository:** `integration-architecture-documentation`  
**Description:** `This file provides documentation on how to build, deploy and test an Integration Architecture node locally. `  
<!-- SPDX-License-Identifier: OGL-UK-3.0 -->

## Pre-requisites

* AWS CLI
* Docker (running)
* Postman/Curl
* Git cli

## Minimal IA node

### Start up identity provider and access control

Fetch source code
```
git clone https://github.com/National-Digital-Twin/ianode-access
```

Start up cognito emulator as identity provider emulator
```
cd ianode-access/cognito-local
docker compose up
```
Wait for terminal window to say "Cognito Local running on http://0.0.0.0:9229"
(and leave that running)

Prepare accounts in emulator
```
cd ianode-access/cognito-local
sh reset_cognito.sh
sh config_cognito.sh
```
Wait for script to complete and window to say "Added users to groups when required".

Start up mongo for ianode-access to use
```
cd ianode-access
docker compose up mongo -d
```

Start up access support mechanism
```
source ./token_env.sh [Sets some environment variables for local running with tokens]
export SCIM_ENABLED=true [So that cognito-local is used]
yarn install
OPENID_PROVIDER_URL=development DEPLOYED_DOMAIN="http://localhost:3000" GROUPS_KEY="cognito:groups" yarn dev [Run server providing API]
```
(leave that running)

Check it's running and account is in place
```
aws --endpoint http://0.0.0.0:9229 cognito-idp initiate-auth --client-id 6967e8jkb0oqcm9brjkrbcrhj --auth-flow USER_PASSWORD_AUTH --auth-parameters USERNAME=test+admin@ndtp.co.uk,PASSWORD=password
```
and note the token id from the output
```
curl -H "Authorization: bearer <id token>" http://localhost:8091/whoami
```
and some details about that user should be shown.

### Prepare authentication for fetching GitHub packages
https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-apache-maven-registry#authenticating-to-github-packages

### Fetch source code and build packages
```
git clone https://github.com/National-Digital-Twin/rdf-abac
cd rdf-abac
mvn clean install
cd ..
git clone https://github.com/National-Digital-Twin/jwt-servlet-auth
cd jwt-servlet-auth
mvn clean install
git clone https://github.com/National-Digital-Twin/secure-agents-lib.git
cd secure-agents-lib
(Ensure Docker is running as the tests use it)
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

### Start up secure-agent-graph

Start in-memory secure agent graph with dev config TODO Indicate anything different for production in config file
```
USER_ATTRIBUTES_URL=http://localhost:8091 JWKS_URL=disabled \
java \
-Dfile.encoding=UTF-8 \
-Dsun.stdout.encoding=UTF-8 \
-Dsun.stderr.encoding=UTF-8 \
-classpath "sag-server/target/classes:sag-system/target/classes:sag-docker/target/dependency/*" \
uk.gov.dbt.ndtp.secure.agent.graph.SecureAgentGraph \
--config sag-docker/mnt/config/dev-server-vanilla.ttl
```

### Run basic test for minimal IA node functionality

Upload knowledge and fetch data
```
curl -XPOST -T <path-to>/secure-agent-graph/sag-docker/Test/data1.trig --header "Content-type: text/trig" http://localhost:3030/ds/upload
curl http://localhost:3030/ds # Fetches both records
```

Check local JWKS keys accessible
```
curl http://localhost:9229/local_6GLuhxhD/.well-known/jwks.json # Should output data
```

### Run access control test

Start up IANode with GraphQL and ABAC
```
USER_ATTRIBUTES_URL=http://localhost:8091 JWKS_URL=http://localhost:9229/local_6GLuhxhD/.well-known/jwks.json \
java \
-Dfile.encoding=UTF-8 \
-Dsun.stdout.encoding=UTF-8 \
-Dsun.stderr.encoding=UTF-8 \
-classpath "sag-server/target/classes:sag-system/target/classes:sag-docker/target/dependency/*" \
uk.gov.dbt.ndtp.secure.agent.graph.SecureAgentGraph \
--config sag-docker/mnt/config/dev-server-graphql.ttl
```

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

## Single IA node

### Start up Kafka
(based on https://kafka.apache.org/quickstart)
```
docker pull apache/kafka:3.9.0
docker run -p 9092:9092 apache/kafka:3.9.0
```

Download tools from Apache Kafka via https://www.apache.org/dyn/closer.cgi?path=/kafka/3.9.0/kafka_2.13-3.9.0.tgz
```
tar -xzf ~/Downloads/kafka_2.13-3.9.0.tgz
cd kafka_2.13-3.9.0
```

Create a Kafka topic
```
bin/kafka-topics.sh --create --topic RDF --bootstrap-server localhost:9092
```

Build command line tool to push messages to Kafka queue
```
cd <your IA root>
git clone https://github.com/National-Digital-Twin/jena-fuseki-kafka.git
cd jena-kafka-client
mvn dependency:build-classpath -DincludeScope=runtime -Dmdep.outputFile=fk.classpath
```
Adjust script called 'fk', changing ```CPJ="$(echo target/jena-kafka-client-*.jar)"``` to ```CPJ="$(echo target/jena-kafka-client-*.jar | sed 's/ /\:/g')"```

Then, restart the IANode but with dev-server-kafka.ttl and create somewhere to store topic meta data.
```
cd <your IA root>/secure-agent-graph
mkdir databases
USER_ATTRIBUTES_URL=http://localhost:8091 JWKS_URL=http://localhost:9229/local_6GLuhxhD/.well-known/jwks.json \
java \
-Dfile.encoding=UTF-8 \
-Dsun.stdout.encoding=UTF-8 \
-Dsun.stderr.encoding=UTF-8 \
-classpath "sag-server/target/classes:sag-system/target/classes:sag-docker/target/dependency/*" \
uk.gov.dbt.ndtp.secure.agent.graph.SecureAgentGraph \
--config sag-docker/mnt/config/dev-server-kafka.ttl
```

```
cd <directory containing 'fk' script>
./fk dump --topic RDF
```
should show no entries ```"offset": -1```

Now push a message into Kafka
```
./fk send --topic RDF <path-to>/secure-agent-graph/sag-docker/Test/data1.trig
./fk dump --topic RDF
```
show should the data is in Kafka

Also, the secure-agent-graph app should have picked up the message and the log files show ```Initial sync : Offset = 0```.

Running the queries should fetch the data as before e.g.
```
curl -XPOST  -H "Authorization: bearer <token-id>" -H "Content-Type: application/json" --data '{"query": "query { node(uri: \"http://example/person4321\") {id properties { predicate value }} }" }' http://localhost:3030/ds/graphql
```

...more to follow regarding other aspects of a single IA node.

© Crown Copyright 2025. This work has been developed by the National Digital Twin Programme and is legally attributed to the Department for Business and Trade (UK) as the governing entity.  
Licensed under the Open Government Licence v3.0.