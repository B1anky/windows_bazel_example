The goal of this tutorial is to ease the development on a Windows machine by using the `bazel` build system.

This template should be used when wanting to develop using g++, clang, or MSVC.

For the purpose of this tutorial, it will go over how to create a toolchain for g++, specifically.

By default, `bazel` will attempt to use the system default compiler. When working on this example, I had both MSVC and g++ installed on the host.
However, the default always preferred to use MSVC over g++, until creating the custom toolchain and pointing it to my MinGW directory containing g++.

To begin you should do the following:
1. Download MinGW via this [link](https://github.com/Vuniverse0/mingwInstaller/releases/download/1.2.0/mingwInstaller.exe).
2. Install to whichever path you'd like, but keep note of this path because you'll have to modify some files in this example to the path you specify.
    - Ensure that MinGW installed properly and you have a valid g++ compiler.
    - Open either `cmd` or `PowerShell` and enter the following command into whichever terminal:
        - `g++ --version`
        - If done properly, you should see something like this:
            ```
            C:\Users\Brett>g++ --version
            g++ (x86_64-win32-seh-rev1, Built by MinGW-Builds project) 13.2.0
            Copyright (C) 2023 Free Software Foundation, Inc.
            This is free software; see the source for copying conditions.  There is NO
            warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
            ```
3. Now it's time to install an editor. I advise Visual Studio Code (VS Code) since it has simple git integration, a myriad of terminal options, and a decent extension library.
    - This can be downloaded via this [link](https://code.visualstudio.com/).
4. After you have your preferred editing environment set up, you need to download `bazel` itself. You can either install `bazelisk` or just get the `bazel.exe` and put it in your MinGW install bin.
   - To download `bazel.exe` navigate to this [bazel-7.1.1-windows-x86_64.exe](https://github.com/bazelbuild/bazel/releases/download/7.1.1/bazel-7.1.1-windows-x86_64.exe).
       - You may need to scroll down the page a little bit until you see the group titled `Assets`.
           - You may also need to expand the `Assets` to show all of them to see the one needed for windows. Select the `Show all ## Assets` link to expand.
           - Scroll down until you see the option for: `bazel-7.1.1-windows-x86_64.exe` (or whichever version is the most recent).
               - Select it, download it, and install it by moving it into your MinGW directory that you installed to before. There is no need to execute it to install it.
5. Clone this repository and update any paths referenced inside of `toolchain\cc_toolchain_config.bzl`.
    - Specifically, update the `MINGW_PATH` and the `MINGW_VERSION` variables with your local host information.
6. Open a terminal and navigate to the directory for this git repo.
7. Execute the following command:
    - `bazel run :hello_world`
    - If it executes properly, you should see in the terminal a print out of a number corresponding to your g++ version.
8. To modify your g++ C++ std version, open the `.bazelrc` and update the `--cxxopt=-std=c++20` version to whatever you want or need.
