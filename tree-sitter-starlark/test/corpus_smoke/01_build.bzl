load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

cc_library(
    name = "core",
    srcs = ["core.cc"],
    hdrs = ["core.h"],
)
