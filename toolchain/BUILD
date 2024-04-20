package(default_visibility = ["//visibility:public"])

filegroup(name = "empty")

cc_toolchain(
    name = "mingw64_toolchain",
    toolchain_identifier = "mingw64-toolchain",
    toolchain_config = ":mingw64_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
)

toolchain(
    name = "cc_toolchain_for_mingw64",
    toolchain = ":mingw64_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:windows",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:windows",
    ],
)

load(":cc_toolchain_config.bzl", "cc_toolchain_config")
cc_toolchain_config(name = "mingw64_config")
