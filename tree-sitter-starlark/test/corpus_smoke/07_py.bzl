py_binary(
    name = "tool",
    srcs = ["tool.py"],
    deps = [
        ":lib",
        "//third_party:requests",
    ],
    visibility = ["//visibility:public"],
)
