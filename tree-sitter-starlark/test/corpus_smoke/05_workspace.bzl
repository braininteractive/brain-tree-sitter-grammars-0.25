workspace(name = "demo")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_go",
    sha256 = "abc123",
    urls = ["https://example.com/rules_go.tar.gz"],
)
