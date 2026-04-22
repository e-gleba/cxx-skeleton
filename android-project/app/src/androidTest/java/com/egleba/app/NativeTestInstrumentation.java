package com.egleba.app;

import androidx.test.runner.AndroidJUnitRunner;

public final class NativeTestInstrumentation extends AndroidJUnitRunner {
    static {
        System.loadLibrary("tests");
    }
}
