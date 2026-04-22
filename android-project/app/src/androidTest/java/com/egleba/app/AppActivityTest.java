package com.egleba.app;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;

import static org.junit.Assert.assertTrue;

@RunWith(Parameterized.class)
public final class AppActivityTest {
    @Parameterized.Parameter
    public String testName;

    @Parameters(name = "{0}")
    public static List<Object[]> data() {
        final String[] names = getTestNames();
        Objects.requireNonNull(names, "Native test names missing: is libtests.so loaded?");

        return Arrays.stream(names)
                .map(name -> new Object[]{ name })
                .toList();
    }

    @Test
    public void run() {
        assertTrue("Native failure: " + testName, runTest(testName));
    }

    private static native String[] getTestNames();

    private static native boolean runTest(String name);
}
