package com.midokura.evpapigatling;


import java.util.HashMap;
import java.util.Map;

import static com.midokura.evpapigatling.SystemPropertiesUtil.getAsDoubleOrElse;
import static com.midokura.evpapigatling.SystemPropertiesUtil.getAsIntOrElse;
import static com.midokura.evpapigatling.SystemPropertiesUtil.getAsStringOrElse;

public final class PerfTestConfig {
    public static final String BASE_URL = getAsStringOrElse("baseUrl", "http://evp-api.midokura");
    public static final int TOTAL_USERS = getAsIntOrElse("totalUsers", 1000);
    public static final long DURATION_MIN = getAsIntOrElse("durationMin", 1);
    public static final int P95_RESPONSE_TIME_MS = getAsIntOrElse("p95ResponseTimeMs", 1000);
    public static final Map<Integer, String> DEVICE_IDS = new HashMap<>() {{
       // Use scripts to get the values
    }};
    public static final Map<Integer, String> MODULE_IDS = new HashMap<>() {{
        // Use scripts to get the values
    }};
    public static final Map<Integer, String> DEPLOYMENT_IDS = new HashMap<>() {{
        // Use scripts to get the values
    }};
    public static final Map<Integer, String> IOT_DEVICES_IDS = new HashMap<>() {{
        // Use scripts to get the values
    }};


}