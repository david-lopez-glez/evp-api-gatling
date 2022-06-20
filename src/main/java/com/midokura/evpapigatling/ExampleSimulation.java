package com.midokura.evpapigatling;

import io.gatling.javaapi.core.ScenarioBuilder;
import io.gatling.javaapi.core.Simulation;
import io.gatling.javaapi.http.HttpProtocolBuilder;

import java.time.Duration;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import java.util.function.Supplier;
import java.util.stream.Stream;

import static com.midokura.evpapigatling.PerfTestConfig.BASE_URL;
import static com.midokura.evpapigatling.PerfTestConfig.DEPLOYMENT_IDS;
import static com.midokura.evpapigatling.PerfTestConfig.DEVICE_IDS;
import static com.midokura.evpapigatling.PerfTestConfig.DURATION_MIN;
import static com.midokura.evpapigatling.PerfTestConfig.IOT_DEVICES_IDS;
import static com.midokura.evpapigatling.PerfTestConfig.MODULE_IDS;
import static com.midokura.evpapigatling.PerfTestConfig.P95_RESPONSE_TIME_MS;
import static com.midokura.evpapigatling.PerfTestConfig.TOTAL_USERS;
import static io.gatling.javaapi.core.CoreDsl.StringBody;
import static io.gatling.javaapi.core.CoreDsl.constantUsersPerSec;
import static io.gatling.javaapi.core.CoreDsl.global;
import static io.gatling.javaapi.core.CoreDsl.scenario;
import static io.gatling.javaapi.http.HttpDsl.http;
import static io.gatling.javaapi.http.HttpDsl.status;

public class ExampleSimulation extends Simulation {

    private static final Random random = new Random();
    HttpProtocolBuilder httpProtocol = http.baseUrl(BASE_URL).header("Content-Type", "application/json");
    Iterator<Map<String, Object>> feeder = Stream.generate((Supplier<Map<String, Object>>) () -> {
        int version1 = random.nextInt(0, 4500000);
        int version2 = random.nextInt(4500000, 9000000);
        int moduleIdKey = random.nextInt(1, MODULE_IDS.size());
        int iotDeviceIdKey = random.nextInt(1, IOT_DEVICES_IDS.size());
        int deploymentIdKey = random.nextInt(1, DEPLOYMENT_IDS.size());
        int deviceIdKey = random.nextInt(1, DEVICE_IDS.size());
        return Map.of(
            "module1Version", version1,
            "module1Name", UUID.randomUUID(),
            "module2Version", version2,
            "module2Name", UUID.randomUUID(),
            "moduleId", MODULE_IDS.get(moduleIdKey),
            "iotDeviceId", IOT_DEVICES_IDS.get(iotDeviceIdKey),
            "deploymentId", DEPLOYMENT_IDS.get(deploymentIdKey),
            "deviceId", DEVICE_IDS.get(deviceIdKey),
            "getDeploymentId", DEPLOYMENT_IDS.get(deploymentIdKey),
            "getDeviceId", DEVICE_IDS.get(deviceIdKey)
        );
    }).iterator();

    /** Scenario steps
     * Create a module
     * Create a module
     * Create a deployment
     * Assign a deployment to a device
     * Get a device
     * Get a deployment
     */
    ScenarioBuilder scn = scenario("health end point calls")
        .feed(feeder)
        .exec(http("create  1st module").post("/v2/module").body(StringBody("""
            {
              "name":"evp-module-config-echo-demo-${module1Name}",
              "version":${module1Version},
              "resourceUrl":"midokura.azurecr.io/evp-module-config-echo:latest",
              "entryPoint":"main",
              "deviceTargetType":"type_of_a_cool_module",
              "hash":"9a69e044048c4e510e803fb07f36c47f2564ea6267c55bc465263f9cfb77d29f"
            }
            """
        )).check(status().is(201)))
        .exec(http("create 2nd module").post("/v2/module").body(StringBody("""
            {
              "name":"evp-module-config-echo-demo-${module2Name}",
              "version":${module2Version},
              "resourceUrl":"midokura.azurecr.io/evp-module-config-echo:latest",
              "entryPoint":"main",
              "deviceTargetType":"type_of_a_cool_module",
              "hash":"9a69e044048c4e510e803fb07f36c47f2564ea6267c55bc465263f9cfb77d29f"
            }
            """
        )).check(status().is(201)))
        .exec(http("create deployment").post("/v2/deployment").body(StringBody("""
            {
              "specs": [
                {
                  "moduleId": "${moduleId}",
                  "description": "Module description",
                  "publishAlias": [ { "topic": "sender-topic", "alias": "salute-publication" } ],
                  "subscribeAlias": [ { "topic": "receiver-dlq-topic", "alias": "errors" } ]
                },
                {
                  "moduleId": "${moduleId}",
                  "description": "Module description",
                  "publishAlias": [ { "topic": "sender-dlq-topic", "alias": "errors" } ],
                  "subscribeAlias": [ { "topic": "receiver-topic",  "alias": "salute-topic" } ]
                }
              ],
             "connections": { "publishTopics": [],  "subscribeTopics": [] }
            }
            """
        )).check(status().is(201)))
        .exec(http("register device").patch("/v2/device/${deviceId}").body(StringBody("""
            { "deploymentId": "${deploymentId}" }
            """
        )).check(status().is(200)))
        .exec(http("retrieve deployment").get("/v2/deployment/${getDeploymentId}").check(status().is(200)))
        .exec(http("retrieve device").get("/v2/device/${getDeviceId}").check(status().is(200)));
    {
        setUp(
            //scn.injectOpen(rampUsers(TOTAL_USERS).during(Duration.ofMinutes(DURATION_MIN))))
            scn.injectOpen(constantUsersPerSec(TOTAL_USERS).during(Duration.ofMinutes(DURATION_MIN)))
        ).protocols(httpProtocol).assertions(
            global().responseTime().percentile3().lt(P95_RESPONSE_TIME_MS),
            global().successfulRequests().percent().gt(95.0)
        );
    }
}
