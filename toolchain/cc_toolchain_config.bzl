
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

load(
   "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
   "feature",
   "flag_group",
   "flag_set",
   "tool_path",
)

load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "artifact_name_pattern",
)

all_link_actions = [
   ACTION_NAMES.cpp_link_executable,
   ACTION_NAMES.cpp_link_dynamic_library,
   ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _impl(ctx):
   tool_paths = [
       tool_path(
           name = "gcc",
           path = "F:/MinGW/mingw64/bin/g++",
       ),
       tool_path(
           name = "ld",
           path = "F:/MinGW/mingw64/bin/ld",
       ),
       tool_path(
           name = "ar",
           path = "F:/MinGW/mingw64/bin/ar",
       ),
       tool_path(
           name = "cpp",
           path = "F:/MinGW/mingw64/bin/cpp",
       ),
       tool_path(
           name = "gcov",
           path = "F:/MinGW/mingw64/bin/gcov",
       ),
       tool_path(
           name = "nm",
           path = "F:/MinGW/mingw64/bin/nm",
       ),
       tool_path(
           name = "objdump",
           path = "F:/MinGW/mingw64/bin/objdump",
       ),
       tool_path(
           name = "strip",
           path = "F:/MinGW/mingw64/bin/strip",
       ),
   ]

   features = [ # NEW
       feature(
           name = "default_linker_flags",
           enabled = True,
           flag_sets = [
               flag_set(
                   actions = all_link_actions,
                   flag_groups = ([
                       flag_group(
                           flags = [
                               "-lstdc++",
                           ],
                       ),
                   ]),
               ),
           ],
       ),
   ]

   return cc_common.create_cc_toolchain_config_info(
       ctx = ctx,
       features = features,
       cxx_builtin_include_directories = [
           "F:/MinGW/mingw64/include",
           "F:/MinGW/mingw64/x86_64-w64-mingw32/include",
           "F:/MinGW/mingw64/lib/gcc/x86_64-w64-mingw32/13.2.0/include-fixed",
           "F:/MinGW/mingw64/lib/gcc/x86_64-w64-mingw32/13.2.0/include",
           "F:/MinGW/mingw64/lib/gcc/x86_64-w64-mingw32/13.2.0",
       ],
       toolchain_identifier = "local",
       host_system_name = "local",
       target_system_name = "local",
       target_cpu = "x64_windows",
       target_libc = "unknown",
       compiler = "g++",
       abi_version = "unknown",
       abi_libc_version = "unknown",
       tool_paths = tool_paths,
       artifact_name_patterns = [
        artifact_name_pattern(
            category_name = "executable",
            prefix = "",
            extension = ".exe",
        ),
    ]
   )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
