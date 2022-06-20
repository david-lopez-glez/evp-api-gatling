package com.midokura.evpapigatling;

public final class SystemPropertiesUtil {
    public static String getAsStringOrElse(String key, String fallback) {
        Object value = System.getProperty(key);
        if (value == null) {
            return fallback;
        }
        return (String) value;
    }
    public static int getAsIntOrElse(String key, int fallback) {
        Object value = System.getProperty(key);
        if (value == null) {
            return fallback;
        }
        return Integer.parseInt((String) value);
    }
}