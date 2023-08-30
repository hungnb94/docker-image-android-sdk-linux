## Overview

Docker image to build & test an Android app *.apk. The image contains:

- cmdline-tools: 11.0
- platforms;android-33
- platform-tools
- build-tools;30.0.3

## Limit

NDK is not supported.
And need to investigate in the future.

### Tips to by pass NDK

1. Build release apk
2. Unzip apk file
3. Copy .so files in folder lib: lib/arm64-v8a, lib/armeabi-v7a, lib/x86, lib/x86_64
4. Paste .so files into folder app/src/main/jniLibs:
5. Then open file app/build.gradle and disable NDK build by delete externalNativeBuild