#!/usr/bin/env bash

token=$(curl -s  http://thingsboard.midokura/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"gomidogo@midokura.com", "password":"GoMidoGo"}'\
  | jq -r .token)
echo "Set variable in the environment:"
echo "export TB_TOKEN=\"${token}\""