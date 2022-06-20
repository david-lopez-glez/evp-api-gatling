#!/usr/bin/env bash

DURATION_MINUTES=1
CONCURRENT_USERS=100
JAVA_OPTS="-DbaseUrl=http://evp-api.midokura  -DdurationMin=${DURATION_MINUTES} -DtotalUsers=${CONCURRENT_USERS}"
SIMULATION_NAME=com.midokura.evpapigatling.ExampleSimulation
java ${JAVA_OPTS} -cp target/evp-api-gatling.jar io.gatling.app.Gatling -s "${SIMULATION_NAME}"
