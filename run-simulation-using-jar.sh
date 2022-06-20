#!/usr/bin/env bash
JAVA_OPTS="-DbaseUrl=http://evp-api.midokura  -DdurationMin=1 -DtotalUsers=100"
SIMULATION_NAME=com.midokura.evpapigatling.ExampleSimulation
java ${JAVA_OPTS} -cp target/evp-api-gatling.jar io.gatling.app.Gatling -s "${SIMULATION_NAME}"
