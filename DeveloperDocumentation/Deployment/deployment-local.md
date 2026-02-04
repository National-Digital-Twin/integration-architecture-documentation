# Running an IA node locally

**Repository:** `integration-architecture-documentation`  
**Description:** `This file provides documentation on how to build, deploy and test an Integration Architecture node locally. `  
<!-- SPDX-License-Identifier: OGL-UK-3.0 -->

## Pre-requisites

Note. if your on windows use WSL2 otherwise expect some issues.

* NOTE. use the wsl file system NOT `/mnt/c` otherwise some tests will fail
* Docker (ensure `docker ps` command works)
* AWS CLI (with `aws configure` setup)
* Postman/Curl
* Github PAT token set to allow retrieval of maven packages from Github Packages (see below)
* java 21
* Node.js 20 (Alpine 3.20)
* Yarn (`yarn install && yarn dev`)
* jq
* maven

### GitHubPAT
you need a file called `~/.m2/settings.xml` replace the tokens in the below with your details  

[Ref:]https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-apache-maven-registry#authenticating-to-github-packages

``` xml
<settings>
    <servers>
      <server>
        <id>github</id>
        <username>your github email here</username>
        <password>your github PAT token here</password>
      </server>
    </servers>
</settings>
```

## Minimal IA node

### Start up identity provider and access control

Fetch source code
``` bash
git clone https://github.com/National-Digital-Twin/ianode-access
```

Start up cognito emulator as identity provider emulator
``` bash
cd ianode-access/cognito-local
docker compose up -d
```
Wait for terminal window to say "Cognito Local running on http://0.0.0.0:9229"
(and leave that running)

Prepare accounts in emulator
``` bash
export COGNITO_ADMIN_PASSWORD=<choose a password>
sudo sh reset_cognito.sh
sh config_cognito.sh
```
is you get at message about specifying a region, then youll need to configure aws (or aws login)

Wait for script to complete and window to say "Added users to groups when required".

Start up mongo for ianode-access to use
``` bash
cd ../ # into ianode-access folder
docker compose up mongo -d
```

Start up access support mechanism
``` bash
source ./cognito_env.sh #[Sets some environment variables for local running with tokens]
export SCIM_ENABLED=true #[So that cognito-local is used]
yarn install
OPENID_PROVIDER_URL=development DEPLOYED_DOMAIN="http://localhost:3000" GROUPS_KEY="cognito:groups" yarn dev [Run server providing API]
```
(leave that running)

Check it's running and account is in place, switch to a second shell/bash terminal
``` bash
export COGNITO_ADMIN_PASSWORD=<from above>
cd ianode-access
export CLIENT_ID=$(cat cognito-local/.client_id)
source ../ianode-access/cognito_env.sh
aws --endpoint http://0.0.0.0:9229 cognito-idp initiate-auth --client-id $CLIENT_ID --auth-flow USER_PASSWORD_AUTH --auth-parameters USERNAME=test+admin@ndtp.co.uk,PASSWORD=$COGNITO_ADMIN_PASSWORD
```
run again via script to grab as variable for future 
``` bash
source cognito-local/fetch_id_token.sh
```

``` bash
curl -H "Authorization: bearer $COGNITO_ID_TOKEN" http://localhost:8091/whoami
```
and some details about that user should be shown.

### Prepare authentication for fetching GitHub packages
https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-apache-maven-registry#authenticating-to-github-packages

### Fetch source code and build packages
``` bash
cd .. # move back to your root
git clone https://github.com/National-Digital-Twin/rdf-abac
cd rdf-abac
mvn clean install -DskipTests
cd .. # move back to your root
git clone https://github.com/National-Digital-Twin/jwt-servlet-auth
cd jwt-servlet-auth
mvn clean install -DskipTests
cd .. # move back to your root
git clone https://github.com/National-Digital-Twin/secure-agents-lib.git
cd secure-agents-lib # (Ensure Docker is running as the tests use it)
mvn clean install -DskipTests


cd .. # move back to your root
git clone https://github.com/National-Digital-Twin/jena-fuseki-kafka
cd jena-fuseki-kafka
mvn clean install -DskipTests
cd .. # move back to your root
git clone https://github.com/National-Digital-Twin/graphql-jena
cd graphql-jena
mvn clean install -Dmaven.javadoc.skip=true
cd .. # move back to your root
git clone https://github.com/National-Digital-Twin/fuseki-yaml-config
cd fuseki-yaml-config
mvn clean install -DskipTests
cd .. # move back to your root
git clone https://github.com/National-Digital-Twin/secure-agent-graph.git
cd secure-agent-graph
mvn clean install -DskipTests
```

### Start up secure-agent-graph

Start an in-memory secure agent graph with dev config
``` bash
cd root of projects/secure-agent-graph # skip if already in secure-agent-graph folder (from above)
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

with secure graph running, switch to thrid shell/bash terminal
Upload knowledge and fetch data
``` bash
cd root of projects.
curl -XPOST -T secure-agent-graph/sag-docker/Test/data1.trig --header "Content-type: text/trig" http://localhost:3030/ds/upload
curl http://localhost:3030/ds # Fetches both records
```

Check local JWKS keys accessible
``` bash
curl http://localhost:9229/local_6GLuhxhD/.well-known/jwks.json # Should output data
```



### Run access control test
Switch to second shell/bash terminal with secure-agent-graph still running and stop it with ctrl-c

Start up IANode with GraphQL and ABAC
``` bash

USER_ATTRIBUTES_URL=http://localhost:8091 JWKS_URL=http://localhost:9229/local_6GLuhxhD/.well-known/jwks.json \
java \
-Dfile.encoding=UTF-8 \
-Dsun.stdout.encoding=UTF-8 \
-Dsun.stderr.encoding=UTF-8 \
-classpath "sag-server/target/classes:sag-system/target/classes:sag-docker/target/dependency/*" \
uk.gov.dbt.ndtp.secure.agent.graph.SecureAgentGraph \
--config sag-docker/mnt/config/dev-server-graphql.ttl
```
switch back to third shell/bash terminal again
Try to upload file, should fail as unauthenticated
``` bash
curl -XPOST -T secure-agent-graph/sag-docker/Test/data1.trig --header "Content-type: text/trig" http://localhost:3030/ds/upload
```

Obtain token and try again (script fetch_id_token.sh fetch's the token and sets COGNITO_ID_TOKEN). 

This should show person4321 and phone number ending 333.
``` bash
export COGNITO_ADMIN_PASSWORD=<from above> # should be still set in this shell/bash
cd root of projects/ianode-access/
export CLIENT_ID=$(cat cognito-local/.client_id)
source cognito-local/fetch_id_token.sh "test+user+admin@ndtp.co.uk"
curl -XPOST -T ../secure-agent-graph/sag-docker/Test/data1.trig --header "Content-type: text/trig" -H "Authorization: bearer $COGNITO_ID_TOKEN" http://localhost:3030/ds/upload
curl -X POST -H "Authorization: bearer $COGNITO_ID_TOKEN" -d "query=select ?s ?p ?o where { ?s ?p ?o . }" http://localhost:3030/ds
```

Obtain token for second user and fetch data. This should show person4321 with number ending 333 AND person9876 with a empId value and no phone number.
``` bash
source cognito-local/fetch_id_token.sh "test+user@ndtp.co.uk"
curl -X POST -H "Authorization: bearer $COGNITO_ID_TOKEN" -d "query=select ?s ?p ?o where { ?s ?p ?o . }" http://localhost:3030/ds
```

Run a GraphQL query
``` bash
curl -XPOST  -H "Authorization: bearer $COGNITO_ID_TOKEN" -H "Content-Type: application/json" --data '{"query": "query { node(uri: \"http://example/person4321\") {id properties { predicate value }} }" }' http://localhost:3030/ds/graphql
```
should output 
``` json 
{"data":{"node":{"id":"http://example/person4321","properties":[{"predicate":"http://example/phone","value":"0400 111 333"}]}}}
```

## Single IA node

### Start up Kafka
(based on https://kafka.apache.org/quickstart)
``` bash
docker pull apache/kafka:3.9.0
docker run -p 9092:9092 -d apache/kafka:3.9.0
```

Download tools from Apache Kafka via https://www.apache.org/dyn/closer.cgi?path=/kafka/3.9.0/kafka_2.13-3.9.0.tgz
``` bash
cd root of projects
wget wget https://dlcdn.apache.org/kafka/3.9.0/kafka_2.13-3.9.0.tgz # or copy download of the above into the root of projects
tar -xzf kafka_2.13-3.9.0.tgz
cd kafka_2.13-3.9.0
```

Create a Kafka topic
``` bash
bin/kafka-topics.sh --create --topic RDF --bootstrap-server localhost:9092
```

Build command line tool to push messages to Kafka queue
``` bash
cd <root of projects>
# if not cloned earlier
git clone https://github.com/National-Digital-Twin/jena-fuseki-kafka.git
cd jena-fuseki-kafka/jena-kafka-client
mvn dependency:build-classpath -DincludeScope=runtime -Dmdep.outputFile=fk.classpath
```
There is a script called 'fk' in the folder 'jena-fuseki-kafka/jena-kafka-client' which will need editing, open the script in your favorite text editor, changing the line ```CPJ="$(echo target/jena-kafka-client-*.jar)"``` to ```CPJ="$(echo target/jena-kafka-client-*.jar | sed 's/ /\:/g')"```

Then, switch to second shell/bash terminal, restart the IANode but with dev-server-kafka.ttl and create somewhere to store topic meta data.
ctrl-c to stop the process then
``` bash
# should be here already `<root of projects>/secure-agent-graph`
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
switch back to third shell/bash terminal
``` bash
cd <directory containing 'fk' script> # root of projects/jena-fuseki-kafka/jena-kafka-client
./fk dump --topic RDF
```
should show no entries ```"offset": -1```

Now push a message into Kafka

``` bash
./fk send --topic RDF ../../secure-agent-graph/sag-docker/Test/data1.trig
./fk dump --topic RDF
```
should show the data that is in Kafka

Also, the secure-agent-graph app should have picked up the message and the log files show ```Batch: Finished [-1, 0] in ... ```.

Running the queries should fetch the data as before e.g.
``` bash
cd <root of projects>/ianode-access
source cognito-local/fetch_id_token.sh "test+user+admin@ndtp.co.uk"
curl -XPOST  -H "Authorization: bearer $COGNITO_ID_TOKEN" -H "Content-Type: application/json" --data '{"query": "query { node(uri: \"http://example/person4321\") {id properties { predicate value }} }" }' http://localhost:3030/ds/graphql
```

...more to follow regarding other aspects of a single IA node.

© Crown Copyright 2025. This work has been developed by the National Digital Twin Programme and is legally attributed to the Department for Business and Trade (UK) as the governing entity.  
Licensed under the Open Government Licence v3.0.