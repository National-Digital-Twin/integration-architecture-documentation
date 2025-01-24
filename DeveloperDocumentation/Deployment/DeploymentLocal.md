# Running an IANode locally

## Pre-requisites

* AWS CLI
* Docker
* Postman/Curl
* Git cli

## Start up access control
```
docker compose up mongo
```

```
git clone https://github.com/National-Digital-Twin/telicent-access
cd telicent-access/cognito-local
sh reset_cognito.sh
docker compose up
sh config_cognito.sh
```

This creates access details for test+admin@telicent.io, test+user@telicent.io, test+user+admin@telicent.io and test@telicent.io.

```
cd ..
scripts/dev-docker-setup.sh
```

Generate tokens for test+admin@telicent.io or whichever user you wish to use next.
```
aws --endpoint http://0.0.0.0:9229 cognito-idp initiate-auth --client-id 6967e8jkb0oqcm9brjkrbcrhj --auth-flow USER_PASSWORD_AUTH --auth-parameters USERNAME=test+admin@telicent.io,PASSWORD=password
```

Copy the ID Token from the result of running the command and use that in the whoami call next in order to set up the account.

```
curl -H "Authorization: bearer <id token>" http://localhost:8091/whoami
```

== Start up smart-cache-graph

TODO