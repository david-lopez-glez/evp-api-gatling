#!/usr/bin/env bash

for i in {1..50}
do
	printf -v name 'gatling-test%02d' "$i"
	iotId=$(curl -s  http://thingsboard.midokura/api/device \
		  -H "Content-Type: application/json" \
	    -H 'X-Authorization: Bearer '"${TB_TOKEN}" \
      -d "{\"name\":\"${name}\",\"label\":\"\",\"additionalInfo\":{\"gateway\":false,\"overwriteActivityTime\":false,\"description\":\"\"},\"customerId\":null}" \
	    | jq -r .id.id)
	echo "put(${i}, \"${iotId}\");"
done
