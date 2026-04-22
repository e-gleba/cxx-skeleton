#include <chrono>
#include <concepts>
#include <cstdint>
#include <doctest/doctest.h>
#include <thread>

// C++20 Concept to verify compiler support for "Real Work" types
template <typename T>
concept Numeric = std::integral<T> || std::floating_point<T>;

DOCTEST_TEST_SUITE("engine environment")
{
    // 1. Test C++20 standard support and math
    DOCTEST_TEST_CASE("C++20 Concepts and Math")
    {
        auto multiply = []<Numeric T>(T a, T b) { return a * b; };

        DOCTEST_CHECK_EQ(multiply(10, 5), 50);
        DOCTEST_CHECK_EQ(multiply(2.5f, 2.0f), 5.0f);
    }

    // 2. Test High-Resolution Time (Critical for Game Engines)
    DOCTEST_TEST_CASE("High-Resolution Timer Validity")
    {
        using namespace std::chrono_literals;

        auto start = std::chrono::steady_clock::now();

        // Simulate a small engine workload or frame wait
        std::this_thread::sleep_for(10ms);

        auto end = std::chrono::steady_clock::now();
        auto duration =
            std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

        // Verify the clock is actually ticking on the device hardware
        DOCTEST_CHECK(duration.count() >= 10);
        DOCTEST_CHECK(duration.count() < 100); // Sanity check
    }

    // 3. Test Threading (Verify NDK can spawn worker threads)
    DOCTEST_TEST_CASE("Native Threading Support")
    {
        bool        thread_ran = false;
        std::thread worker([&]() { thread_ran = true; });

        worker.join();
        DOCTEST_CHECK(thread_ran);
    }
}

DOCTEST_TEST_SUITE("math playground")
{
    [[nodiscard]] static constexpr std::int32_t factorial(
        std::int32_t n) noexcept
    {
        return (n <= 1) ? 1 : n * factorial(n - 1);
    }

    DOCTEST_TEST_CASE("Factorial function" * doctest::test_suite("math"))
    {
        DOCTEST_CHECK_EQ(factorial(0), 1);
        DOCTEST_CHECK_EQ(factorial(5), 120);
        DOCTEST_CHECK_EQ(factorial(10), 3'628'800);
    }
}
