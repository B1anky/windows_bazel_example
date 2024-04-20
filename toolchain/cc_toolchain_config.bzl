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

# Defines your MinGW path variable.
# Update this with your install path for MinGW.
MINGW_PATH = "F:/MinGW/mingw64"

# Inside your MinGW install there should be some versioning
# under the /lib/gcc/x86_64-w64-mingw32/... folders.
# Replace this function return with the numerical values.
MINGW_VERSION = "13.2.0"

def _impl(ctx):
   tool_paths = [
       tool_path(
           name = "gcc",
           path = MINGW_PATH + "/bin/g++",
       ),
       tool_path(
           name = "ld",
           path = MINGW_PATH + "/bin/ld",
       ),
       tool_path(
           name = "ar",
           path = MINGW_PATH + "/bin/ar",
       ),
       tool_path(
           name = "cpp",
           path = MINGW_PATH + "/bin/cpp",
       ),
       tool_path(
           name = "gcov",
           path = MINGW_PATH + "/bin/gcov",
       ),
       tool_path(
           name = "nm",
           path = MINGW_PATH + "/bin/nm",
       ),
       tool_path(
           name = "objdump",
           path = MINGW_PATH + "/bin/objdump",
       ),
       tool_path(
           name = "strip",
           path = MINGW_PATH + "/bin/strip",
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
           MINGW_PATH + "/include",
           MINGW_PATH + "/x86_64-w64-mingw32/include",
           MINGW_PATH + "/lib/gcc/x86_64-w64-mingw32/" + MINGW_VERSION + "/include-fixed",
           MINGW_PATH + "/lib/gcc/x86_64-w64-mingw32/" + MINGW_VERSION + "/include",
           MINGW_PATH + "/lib/gcc/x86_64-w64-mingw32/" + MINGW_VERSION,
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
