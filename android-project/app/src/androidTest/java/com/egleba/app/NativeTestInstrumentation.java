package com.egleba.app;

import android.app.Activity;
import android.app.Instrumentation;
import android.os.Bundle;

public final class NativeTestInstrumentation extends Instrumentation {
    static {
        System.loadLibrary("tests");
    }

    @Override
    public void onCreate(Bundle arguments) {
        super.onCreate(arguments);
        // This starts the thread that calls onStart()
        start();
    }

    @Override
    public void onStart() {
        super.onStart();
        // Your native logic
        runTests("--reporters=junit");

        Bundle results = new Bundle();
        results.putString("stream", "Native tests completed.");
        finish(Activity.RESULT_OK, results);
    }

    public native void runTests(String flags);
}
