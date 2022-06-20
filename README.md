# EVP API 2.0 Gatling

## To sue the playground follow the steps

* Start EVP2 + TBu with the dev tools
* Execute `get_token` and ensure the `TB_TOKEN` variable is accessible for the rest of the scripts.
* Execute the `generate_modules_ids_entries`and paste the output in the `MODULE_IDS` map in the `PerfTestConfig` class.
* Execute the `generate_iot _devices_ids_entries`and paste the output in the `IOT_DEVICES_IDS` map in the `PerfTestConfig` class.
* Execute the `generate_deployment_ids_entries`and paste the output in the `DEPLOYMENT_IDS` map in the `PerfTestConfig` class.
* Execute the `generate_devices_ids_entries`and paste the output in the `DEVICES_IDS` map in the `PerfTestConfig` class.
* Compile the project: `mvn clean package`.
* Adjust the parameters in the  `run-simulation-using-jar` script and execute it.
* To see the results better you can open them in the browser.

The reason to populate the maps is to easily have a set of random Ids to use in the calls to the different endpoints.

## How it works

It is highly recommended to have as many resources free as possible while executing the test.

So far there is only ine scenario that is in the `ExampleSimulation` class the steps in the scenario are:
```java
    /** Scenario steps
     * Create a module
     * Create a module
     * Create a deployment
     * Assign a deployment to a device
     * Get a device
     * Get a deployment
     */
```
Each user which is reflected by the variable `CONCURRENT_USERS` will perform a call to that scenario once per second.
The amount od calls to the scenario is limited by the `DURATION_MINUTES` variable.
Both cna be found in the `run-simulation-using-jar` script.
