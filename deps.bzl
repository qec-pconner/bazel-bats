# From:
# https://stackoverflow.com/questions/47192668/idiomatic-retrieval-of-the-bazel-execution-path#
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

BATS_CORE_BUILD="""
sh_library(
    name = "bats_lib",
    srcs = glob(["libexec/**"]),
)

sh_binary(
    name = "bats",
    srcs = ["bin/bats"],
    visibility = ["//visibility:public"],
    deps = [":bats_lib"],
)

sh_library(
    name = "file_setup_teardown_lib",
    srcs = ["test/file_setup_teardown.bats"],
    visibility = ["//visibility:public"],
    data = glob(["test/fixtures/file_setup_teardown/**"]),
)

sh_library(
    name = "junit_formatter_lib",
    srcs = ["test/junit-formatter.bats"],
    visibility = ["//visibility:public"],
    data = glob(["test/fixtures/junit-formatter/**"]),
)

sh_library(
    name = "parallel_lib",
    srcs = ["test/parallel.bats"],
    visibility = ["//visibility:public"],
    data = glob(["test/fixtures/parallel/**"]),
)

sh_library(
    name = "run_lib",
    srcs = ["test/run.bats"],
    visibility = ["//visibility:public"],
    data = glob(["test/fixtures/run/**"]),
)

sh_library(
    name = "suite_lib",
    srcs = ["test/suite.bats"],
    visibility = ["//visibility:public"],
    data = glob(["test/fixtures/suite/**"]),
)

sh_library(
    name = "test_helper",
    srcs = ["test/test_helper.bash"],
    visibility = ["//visibility:public"],
)

sh_library(
    name = "trace_lib",
    srcs = ["test/trace.bats"],
    visibility = ["//visibility:public"],
    data = glob(["test/fixtures/trace/**"]),
)

exports_files(glob(["test/*.bats"]))
"""

def bazel_bats_dependencies(
    version = "1.7.0",
    sha256 = "ac70c2a153f108b1ac549c2eaa4154dea4a7c1cc421e3352f0ce6ea49435454e"
):
    if not sha256:
        fail("sha256 for bats-core was not supplied.")

    http_archive(
        name = "bats_core",
        build_file_content = BATS_CORE_BUILD,
        urls = [
            "https://github.com/bats-core/bats-core/archive/refs/tags/v%s.tar.gz" % version,
        ],
        strip_prefix = "bats-core-%s" % version,
        sha256 = sha256,
    )
