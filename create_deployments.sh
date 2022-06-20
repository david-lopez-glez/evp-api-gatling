#!/usr/bin/env bash

MODULE_ID="d688ad4d-cc64-4202-a347-322e125d6952"
for i in {1..59}
do
	printf -v name 'test%02d' "$i"
	id=$(curl -s  http://evp-api.midokura/v2/deployment \
	  -H "Content-Type: application/json" \
		-H "X-Authorization: Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJnb21pZG9nb0BtaWRva3VyYS5jb20iLCJzY29wZXMiOlsiVEVOQU5UX0FETUlOIl0sInVzZXJJZCI6ImU0ZmY1MTAwLWVlZTItMTFlYy1iY2ZkLWQ3ODUyYjZkNjA5MSIsImVuYWJsZWQiOnRydWUsImlzUHVibGljIjpmYWxzZSwidGVuYW50SWQiOiJlNDdhNDI4MC1lZWUyLTExZWMtYmNmZC1kNzg1MmI2ZDYwOTEiLCJjdXN0b21lcklkIjoiMTM4MTQwMDAtMWRkMi0xMWIyLTgwODAtODA4MDgwODA4MDgwIiwiaXNzIjoidGhpbmdzYm9hcmQuaW8iLCJpYXQiOjE2NTU2MjIwODQsImV4cCI6MTY1NTYzMTA4NH0.t3ZcGyCvsApqq3FI3BX2o8_s9bdHMtZUvzxhpsFy1pxz6lP-bnJV7Aov6k_ErPOqSVTWFoXvhB1131MPmqDBIA" \
		-d "{\"specs\":[{\"moduleId\":\"${MODULE_ID}\",\"description\":\"Moduledescription\",\"publishAlias\":[{\"topic\":\"sender-topic\",\"alias\":\"salute-publication\"}],\"subscribeAlias\":[{\"topic\":\"receiver-dlq-topic\",\"alias\":\"errors\"}]},{\"moduleId\":\"${MODULE_ID}\",\"description\":\"Moduledescription\",\"publishAlias\":[{\"topic\":\"sender-dlq-topic\",\"alias\":\"errors\"}],\"subscribeAlias\":[{\"topic\":\"receiver-topic\",\"alias\":\"salute-topic\"}]}],\"connections\":{\"publishTopics\":[],\"subscribeTopics\":[]}}"| jq -r .id)
	echo "put(${i}, \"${id}\");"
done

