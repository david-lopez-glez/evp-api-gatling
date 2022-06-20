#!/usr/bin/env bash

for i in {1..59}
do
	printf -v name 'test%02d' "$i"
	id=$(curl -s  http://evp-api.midokura/v2/module \
	  -H "Content-Type: application/json" \
		-H "X-Authorization: Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJnb21pZG9nb0BtaWRva3VyYS5jb20iLCJzY29wZXMiOlsiVEVOQU5UX0FETUlOIl0sInVzZXJJZCI6ImU0ZmY1MTAwLWVlZTItMTFlYy1iY2ZkLWQ3ODUyYjZkNjA5MSIsImVuYWJsZWQiOnRydWUsImlzUHVibGljIjpmYWxzZSwidGVuYW50SWQiOiJlNDdhNDI4MC1lZWUyLTExZWMtYmNmZC1kNzg1MmI2ZDYwOTEiLCJjdXN0b21lcklkIjoiMTM4MTQwMDAtMWRkMi0xMWIyLTgwODAtODA4MDgwODA4MDgwIiwiaXNzIjoidGhpbmdzYm9hcmQuaW8iLCJpYXQiOjE2NTU2MjIwODQsImV4cCI6MTY1NTYzMTA4NH0.t3ZcGyCvsApqq3FI3BX2o8_s9bdHMtZUvzxhpsFy1pxz6lP-bnJV7Aov6k_ErPOqSVTWFoXvhB1131MPmqDBIA" \
		-d "{\"name\":\"evp-module-config-echo-demo\",\"version\":1234${i},\"resourceUrl\":\"midokura.azurecr.io/evp-module-config-echo:latest\",\"entryPoint\":\"main\",\"deviceTargetType\":\"type_of_a_cool_module\",\"hash\":\"9a69e044048c4e510e803fb07f36c47f2564ea6267c55bc465263f9cfb77d29f\"}"| jq -r .id)
	echo "put(${i}, \"${id}\");"
done
