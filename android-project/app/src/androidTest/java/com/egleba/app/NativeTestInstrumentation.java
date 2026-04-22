package com.egleba.app;

import androidx.test.runner.AndroidJUnitRunner;

public final class NativeTestInstrumentation extends AndroidJUnitRunner {
    static {
        // Load library once here for the whole process
        System.loadLibrary("tests");
    }
}
