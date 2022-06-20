#!/usr/bin/env bash

MODULE_ID="PUT HERE A VALID MODULE ID"
for i in {1..50}
do
	id=$(curl -s  http://evp-api.midokura/v2/deployment \
	  -H "Content-Type: application/json" \
    -H 'X-Authorization: Bearer '"${TB_TOKEN}" \
		-d "{\"specs\":[{\"moduleId\":\"${MODULE_ID}\",\"description\":\"Moduledescription\",\"publishAlias\":[{\"topic\":\"sender-topic\",\"alias\":\"salute-publication\"}],\"subscribeAlias\":[{\"topic\":\"receiver-dlq-topic\",\"alias\":\"errors\"}]},{\"moduleId\":\"${MODULE_ID}\",\"description\":\"Moduledescription\",\"publishAlias\":[{\"topic\":\"sender-dlq-topic\",\"alias\":\"errors\"}],\"subscribeAlias\":[{\"topic\":\"receiver-topic\",\"alias\":\"salute-topic\"}]}],\"connections\":{\"publishTopics\":[],\"subscribeTopics\":[]}}"| jq -r .id)
	echo "put(${i}, \"${id}\");"
done

