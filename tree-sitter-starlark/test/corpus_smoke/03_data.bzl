VERSIONS = {
    "protobuf": "3.25.0",
    "grpc": "1.60.0",
}

DEFAULT_DEPS = ["//lib:base"] + select({
    "//config:linux": ["//lib:linux"],
    "//conditions:default": [],
})
