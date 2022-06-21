#!/usr/bin/env bash

moduleId=$(curl -s http://evp-api.midokura/v2/module \
  -H "Content-Type: application/json" \
  -H 'X-Authorization: Bearer '"${TB_TOKEN}" | jq -r .[0].id )
for i in {1..50}
do
    id=$(curl -s  http://evp-api.midokura/v2/deployment \
      -H "Content-Type: application/json" \
      -H 'X-Authorization: Bearer '"${TB_TOKEN}" \
      -d "{\"specs\":[{\"moduleId\":\"${moduleId}\",\"description\":\"Moduledescription\",\"publishAlias\":[{\"topic\":\"sender-topic\",\"alias\":\"salute-publication\"}],\"subscribeAlias\":[{\"topic\":\"receiver-dlq-topic\",\"alias\":\"errors\"}]},{\"moduleId\":\"${moduleId}\",\"description\":\"Moduledescription\",\"publishAlias\":[{\"topic\":\"sender-dlq-topic\",\"alias\":\"errors\"}],\"subscribeAlias\":[{\"topic\":\"receiver-topic\",\"alias\":\"salute-topic\"}]}],\"connections\":{\"publishTopics\":[],\"subscribeTopics\":[]}}"| jq -r .id)
    echo "put(${i}, \"${id}\");"
done

