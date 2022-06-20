#!/usr/bin/env bash

for i in {1..59}
do
	printf -v name 'test%02d' "$i"
	iotId=$(curl -s  http://thingsboard.midokura/api/tenant/devices?deviceName=${name} \
	    		-H "X-Authorization: Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJnb21pZG9nb0BtaWRva3VyYS5jb20iLCJzY29wZXMiOlsiVEVOQU5UX0FETUlOIl0sInVzZXJJZCI6ImU0ZmY1MTAwLWVlZTItMTFlYy1iY2ZkLWQ3ODUyYjZkNjA5MSIsImVuYWJsZWQiOnRydWUsImlzUHVibGljIjpmYWxzZSwidGVuYW50SWQiOiJlNDdhNDI4MC1lZWUyLTExZWMtYmNmZC1kNzg1MmI2ZDYwOTEiLCJjdXN0b21lcklkIjoiMTM4MTQwMDAtMWRkMi0xMWIyLTgwODAtODA4MDgwODA4MDgwIiwiaXNzIjoidGhpbmdzYm9hcmQuaW8iLCJpYXQiOjE2NTU2MjIwODQsImV4cCI6MTY1NTYzMTA4NH0.t3ZcGyCvsApqq3FI3BX2o8_s9bdHMtZUvzxhpsFy1pxz6lP-bnJV7Aov6k_ErPOqSVTWFoXvhB1131MPmqDBIA" \
	    | jq -r .iotId.iotId)
	echo "put(${i}, \"${iotId}\");"
done
