#!/usr/bin/env bash

for i in {1..50}
do
	printf -v name 'gatling-test%02d' "$i"
	iotDeviceId=$(curl -s  http://thingsboard.midokura/api/tenant/devices?deviceName=${name} \
        -H "X-Authorization: Bearer $TB_TOKEN" \
	    | jq -r .id.id)
	id=$(curl -s  http://evp-api.midokura/v2/device \
	  -H "Content-Type: application/json" \
    -H 'X-Authorization: Bearer '"${TB_TOKEN}" \
 		-d "{\"iotDeviceId\": \"${iotDeviceId}\",\"description\": \"Gatling test device: ${name}\"}" \
  	    | jq -r .id)
	echo "put(${i}, \"${id}\");"
done
