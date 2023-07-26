#!/bin/sh


ibmcloud_api_key_demo=$1
url=$2

cmd="curl -X POST "https://iam.cloud.ibm.com/identity/token" -H 'Content-Type: application/x-www-form-urlencoded' -d 'grant_type=urn:ibm:params:oauth:grant-type:apikey&apikey=${ibmcloud_api_key_demo}'"
result=`$cmd | jq -r ".access_token"`
`curl -H "Authorization: Bearer $bearer_token" -X POST "https://${url}/test-database" -H "Content-Type: application/json" 
--data '{ 
    "_id": "001", 
    "order_id": "order1234",
    "satelite_id": "sal123456"
 }'`
