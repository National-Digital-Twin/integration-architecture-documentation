#!/bin/bash

# loads users from cognito, stores the token in a global variable to run smoke tests
# the Token from AWS is sourced from aws-congnito-get-token.sh
# aws_congnito_get_token takes 2 parameters, the user name and their password, this gets saved into a global variable
# which can then be assigned in this script to make calls
# this scrips assumes TEST_USER1, TEST_USER1_PASSWORD, IANODE_API_URL, SECURE_AGENT_GRAPH_URL and TEST_DATA_PERSON1 are set via environment variables

load_testing_data () {
   curl --location "$2" \
   --header 'Content-type: text/trig' \
   --header "Authorization: Bearer $1" \
   --data 'PREFIX rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
   PREFIX rdfs:    <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX ies:     <http://ies.data.gov.uk/ontology/ies4#>
   PREFIX authz:  <http://ndtp.co.uk/security#>
   PREFIX :        <http://example/>

   :person4321 rdf:type ies:Person;
      :phone "0400 111 222" ;
      :phone "0400 111 333" ;
      :empId  4321 ;
      rdfs:label "Jones" ;
      .

   :person9876 rdf:type ies:Person;
      :phone "0777 11 11 11" ;
      :phone "0777 22 22 22" ;
      :empId 9876 ;
      rdfs:label "Smith" ;
      .

   GRAPH authz:labels {
      [ authz:pattern '\'':person4321 :phone "0400 111 333"'\'' ;  authz:label "*" ] .
      [ authz:pattern '\'':person4321 :phone "0400 111 444"'\'' ;  authz:label "employee | contractor" ] .
      [ authz:pattern '\'':person9876 :empId 9876'\'' ;  authz:label "employee" ] .
      [ authz:pattern '\'':person4321 :empId 321'\'' ;  authz:label "employee" ] .
   }
   '
}

api_get_user_test () {
  echo ''
  echo 'API Get User'
  response=$(curl -H "Authorization: Bearer $1" --silent --write-out "%{http_code}" $2 )

  if [[ $response  -ne 200 ]]; then
      echo "Failed HTTP Response: ${response:(-3)}"
      exit 1
  fi

  echo "HTTP Response Code: ${response:(-3)}"
  if echo $response | grep "$3"  1>/dev/null
    then
      echo "PASSED: API get_user_test ENDPOINT: $2  test: $3"
    else
      echo "FAILED: API get_user_test ENDPOINT: $2 failed  test: $3"
 fi
}

sqarql_test () {
  echo ''
  echo 'Sqarql Test'
  response=$(curl -X POST -H "Authorization: Bearer $1"  --silent --write-out "%{http_code}"  "$2" -d 'query=SELECT * { ?s ?p ?o }')
  content=$(sed '$ d' <<< "$response")

  if [[ $response  -ne 200 ]]; then
    echo "Failed HTTP Response: ${response:(-3)}"
    exit 1
  fi

  echo "HTTP Response Code: ${response:(-3)}"
  if echo $content | grep "$3" 1>/dev/null
     then
        echo "PASSED: sqarql_test ENDPOINT: $2  test: $3"
      else
        echo "FAILED: sqarql_test ENDPOINT: $2 failed  test: $3"
  fi
}

graphql_test () {
  echo ''
  echo 'Graphql Test'

  response=$(curl  --location --silent --write-out "%{http_code}" "$2" \
                   --header 'Content-Type: application/json' \
                   --header "Authorization: Bearer $1" \
                   --data '{"query":"query { node(uri: \"http://example/person4321\") {id properties { predicate value }} }","variables":{}}')

  if [[ $response  -ne 200 ]]; then
    echo "Failed HTTP Response: ${response:(-3)}"
    exit 1
  fi

  if echo $response | grep "$3" 1>/dev/null
    then
      echo "PASSED: graphql_test ENDPOINT: $2  test: $3"
    else
      echo "FAILED: graphql_test ENDPOINT: $2 failed  test: $3"
  fi
}

query_test () {
  echo ''
  echo 'Query Test'
  response=$(curl --location --silent --write-out "%{http_code}" "$2" \
                  --header 'Content-Type: application/x-www-form-urlencoded' \
                  --header "Authorization: Bearer $1" \
                  --data-urlencode 'query=select ?s ?p ?o where { ?s ?p ?o . }' )

  if [[ $response  -ne 200 ]]; then
      echo "Failed HTTP Response: ${response:(-3)}"
      exit 1
  fi

  echo "HTTP Response Code: ${response:(-3)}"
  if echo $response | grep "$3" 1>/dev/null
    then
      echo "PASSED: query_test ENDPOINT: $2  test: $3"
    else
      echo "FAILED: query_test ENDPOINT: $2 failed  test: $3"
   fi

}

#you will need to source each time to get a new token for a user, assign the new token to a local variable
#before calling any testing functions and pass it in as a parameter
source aws-congnito-get-token.sh $TEST_USER1 $TEST_USER1_PASSWORD
USER1_TOKEN=$CURRENT_NDTP_JWT

echo 'API TEST'
api_get_user_test $USER1_TOKEN "$IANODE_API_URL/whoami" $TEST_USER1

echo ''
echo 'Secure Agent Graph Tests'

load_testing_data $USER1_TOKEN "$SECURE_AGENT_GRAPH_URL/ds/upload"
sqarql_test $USER1_TOKEN "$SECURE_AGENT_GRAPH_URL/ds/sparql?format=text" $TEST_DATA_PERSON1
graphql_test $USER1_TOKEN "$SECURE_AGENT_GRAPH_URL/ds/graphql" $TEST_DATA_PERSON1
query_test $USER1_TOKEN "$SECURE_AGENT_GRAPH_URL/ds" $TEST_DATA_PERSON1
