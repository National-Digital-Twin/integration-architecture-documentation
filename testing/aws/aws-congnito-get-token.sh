#!/bin/bash

NDTP_USER_POOL_ID=$(aws cognito-idp list-user-pools --region $AWS_REGION --max-results 10 --query "UserPools[?Name=='ndtp-testing'] | [0]" | jq -r .Id)

CLIENT_ID=$(aws cognito-idp list-user-pool-clients --region $AWS_REGION --user-pool-id $NDTP_USER_POOL_ID --query "UserPoolClients[?ClientName=='ndtp-testing-client']|[0]" | jq -r .ClientId)
CLIENT_SECRET=$(aws cognito-idp describe-user-pool-client --region $AWS_REGION --user-pool-id $NDTP_USER_POOL_ID --client-id $CLIENT_ID | jq -r .UserPoolClient.ClientSecret)

SECRET_HASH=$(echo -n "$1$CLIENT_ID" | openssl dgst -sha256 -hmac $CLIENT_SECRET -binary | openssl enc -base64)

export CURRENT_NDTP_JWT=$(aws --endpoint https://cognito-idp.$AWS_REGION.amazonaws.com cognito-idp initiate-auth --client-id $CLIENT_ID --auth-flow USER_PASSWORD_AUTH --auth-parameters "USERNAME=$1,PASSWORD=$2,SECRET_HASH=$SECRET_HASH" | jq -r .AuthenticationResult.IdToken)
