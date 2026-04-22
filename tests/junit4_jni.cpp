#include "main.h"

/// See
/// https://docs.oracle.com/javase/8/docs/technotes/guides/jni/spec/functions.html
#include <android/log.h>
#include <jni.h>

#include <iostream>

#include <doctest/doctest.h>

namespace {
struct android_logbuf final : std::streambuf
{
    static constexpr const auto tag      = "native_tests";
    static constexpr size_t     buf_size = 512;
    char                        buf_[buf_size];

    android_logbuf() { setp(buf_, buf_ + buf_size - 1); }

    ~android_logbuf() override { overflow(traits_type::eof()); }

    int_type overflow(int_type ch) override
    {
        if (ch == traits_type::eof() || pptr() == epptr()) {
            flush();
            if (ch == traits_type::eof())
                return traits_type::not_eof(ch);
        }
        *pptr() = static_cast<char>(ch);
        pbump(1);
        if (ch == '\n')
            flush();
        return ch;
    }

    int sync() override
    {
        flush();
        return 0;
    }

private:
    void flush()
    {
        if (auto n = pptr() - pbase(); n > 0) {
            // Remove trailing \n to avoid double newline in logcat
            if (pbase()[n - 1] == '\n')
                --n;
            if (n > 0) {
                std::array<char, buf_size> temp;
                std::copy(pbase(), pbase() + n, temp.data());
                temp[n] = '\0';
                __android_log_write(ANDROID_LOG_INFO, tag, temp.data());
            }
            setp(buf_, buf_ + buf_size - 1);
        }
    }
};

static const bool android_log_redirected = [] {
    static android_logbuf buf;
    std::cout.rdbuf(&buf);
    std::cerr.rdbuf(&buf);
    return true;
}();
} // namespace

extern "C" JNIEXPORT jobjectArray JNICALL
Java_com_egleba_app_AppActivityTest_getTestNames(JNIEnv* env, const jclass)
{
    constexpr const char* const jstring_class_name = "java/lang/String";
    const jclass java_string_class = env->FindClass(jstring_class_name);
    if (!java_string_class) {
        env->ExceptionDescribe();

        using namespace std::string_literals;
        throw std::runtime_error("java class not found: "s +
                                 jstring_class_name);
    }

    const std::set<std::string> tests        = get_all_tests();
    const jobjectArray          tests_to_run = env->NewObjectArray(
        static_cast<int>(tests.size()), java_string_class, nullptr);
    if (!tests_to_run) {
        throw std::runtime_error(
            "failed to allocate java object array of length " +
            std::to_string(tests.size()));
    }

    jsize i = 0;
    for (auto& tc : tests) {
        env->SetObjectArrayElement(
            tests_to_run, i, env->NewStringUTF(tc.data()));
        env->ExceptionDescribe();
        i++;
    }
    return tests_to_run;
}

extern "C" JNIEXPORT jboolean JNICALL
Java_com_egleba_app_AppActivityTest_runTest(JNIEnv* env,
                                            const jclass,
                                            const jstring jname)
{
    const char* name = env->GetStringUTFChars(jname, nullptr);
    if (!name) {
        throw std::runtime_error("failed to convert jstring to char*");
    }

    doctest::Context context;
    context.setOption("test-case", name);
    context.setOption("duration", true);

    // CRITICAL: Prevents doctest from calling exit() which would
    // terminate the Android process instead of returning to Java
    context.setOption("no-exitcode", true);

    const int result = context.run();
    env->ReleaseStringUTFChars(jname, name);
    return result == 0 ? JNI_TRUE : JNI_FALSE;
}

extern "C" JNIEXPORT jboolean JNICALL
Java_com_egleba_app_NativeTestInstrumentation_runTests(JNIEnv* env,
                                                       const jclass,
                                                       const jstring jname)
{
    doctest::Context context;
    context.setOption("duration", true);

    // CRITICAL: Prevents doctest from calling exit() which would
    // terminate the Android process instead of returning to Java
    context.setOption("no-exitcode", true);

    const int result = context.run();
    return result == 0 ? JNI_TRUE : JNI_FALSE;
}
