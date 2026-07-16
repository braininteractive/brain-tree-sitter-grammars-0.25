set(MY_NAME "demo")
set(MY_SOURCES main.cpp util.cpp helper.cpp)
set(MY_FLAG ON CACHE BOOL "an option stored in the cache")

set(GREETING "Hello, ${MY_NAME}!")
set(FROM_ENV "$ENV{HOME}/subdir")
set(FROM_CACHE "$CACHE{MY_FLAG}")

message(STATUS "name is ${MY_NAME} and nested ${OUTER_${INNER}_VAR}")
unset(MY_FLAG CACHE)
