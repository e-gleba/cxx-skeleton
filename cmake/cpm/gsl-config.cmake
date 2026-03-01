cpmaddpackage(
    NAME
    gsl
    GITHUB_REPOSITORY
    microsoft/GSL
    EXCLUDE_FROM_ALL
    ON
    GIT_TAG
    v4.2.1
    OPTIONS
    "GSL_TEST OFF"
    "GSL_INSTALL OFF"
    "GSL_CXX_STANDARD 23")
