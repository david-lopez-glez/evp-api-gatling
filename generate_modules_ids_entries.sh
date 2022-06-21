#!/usr/bin/env bash

for i in {1..50}
do
	id=$(curl -s http://evp-api.midokura/v2/module \
	  -H 'X-Authorization: Bearer '"${TB_TOKEN}" \
	  -H "Content-Type: application/json" \
		-d "{\"name\":\"evp-module-config-echo-gatling\",\"version\":4444${i},\"resourceUrl\":\"midokura.azurecr.io/evp-module-config-echo:latest\",\"entryPoint\":\"main\",\"deviceTargetType\":\"type_of_a_cool_module\",\"hash\":\"9a69e044048c4e510e803fb07f36c47f2564ea6267c55bc465263f9cfb77d29f\"}"| jq -r .id)
	echo "put(${i}, \"${id}\");"
done
