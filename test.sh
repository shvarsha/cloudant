#!/bin/sh

ibmcloud_api_key_demo=$1

url=$2

echo $url

echo $ibmcloud_api_key_demo


bearer_token=$(curl -X POST "https://iam.cloud.ibm.com/identity/token" -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=urn:ibm:params:oauth:grant-type:apikey&apikey=${ibmcloud_api_key_demo}" | jq -r ".access_token")

echo "#####################"

curl -X GET --location "${url}/test-database" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer ${bearer_token}" \
--data '{
    "_id": "001",
    "order_id": "order1234",
    "satelite_id": "sal123456"
 }'
