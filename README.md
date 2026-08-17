# Amiberry for Android / ChromeOS

![Version](https://img.shields.io/badge/Amiberry-8.3.0-blue)
![Android](https://img.shields.io/badge/Android-10%2B-green)
![ChromeOS](https://img.shields.io/badge/ChromeOS-optimized-yellow)
![ABI](https://img.shields.io/badge/ABI-arm64--v8a%20%7C%20x86__64-lightgrey)
![License](https://img.shields.io/badge/license-GPLv3-blue)

**Android / ChromeOS focused port of [Amiberry](https://github.com/BlitterStudio/amiberry), based on Amiberry 8.3.0.**

This fork concentrates on running Amiberry as a native Android application with additional fixes and usability changes for Chromebooks. It keeps the Amiberry/WinUAE emulation core while adapting the Android build, launcher, input handling, display modes and desktop-style ChromeOS experience.

## Android / ChromeOS changes

- ChromeOS-friendly launcher startup using a landscape tablet/freeform window preference.
- Improved physical mouse and captured relative-pointer handling on ChromeOS.
- Sub-pixel relative mouse movement handling for smoother small movements.
- Slightly increased physical mouse speed for desktop-style Chromebook use.
- Smaller Amiberry GUI scaling on large Android/ChromeOS displays.
- Additional Android RTG/Picasso96 resolutions when SDL does not expose sufficient host fullscreen modes.
- Correct physical Y/Z keyboard handling for QWERTZ keyboards while leaving the final keyboard layout to AmigaOS.
- ChromeOS touchpad-generated synthetic Enter/Return events are filtered so a light touchpad tap does not press Return inside AmigaOS.
- Touchpad tap-to-click emulation is intentionally **not** enabled; normal physical mouse/touchpad press, hold, drag and resize behavior remains on the native SDL input path.
- Android-specific fix for the `Expansion > Expansions` GUI crash.
- Windows-host Android build fixes for Gradle/CMake/Ninja path-length issues and deeply nested SDL dependencies.
- ARM64 and x86_64 Android builds from the same project.

## Requirements

| Component | Version / setting |
|---|---|
| Source base | Amiberry 8.3.0 |
| Android Studio | 2025.2.2 tested |
| Java / JVM | 17 |
| Android Gradle Plugin | 8.13.2 |
| Gradle | 8.13 |
| Kotlin | 2.3.20 |
| Compile SDK | 36 |
| Minimum Android | API 29 / Android 10 |
| Target SDK | 36 |
| Android NDK | 29.0.14206865 |
| CMake | 3.22.1 |
| ABIs | `arm64-v8a`, `x86_64` |

## Installation and setup

Install an APK built from this repository on a supported Android or ChromeOS device. The release package ID is:

```text
com.blitterstudio.amiberry
```

The debug variant uses:

```text
com.blitterstudio.amiberry.debug
```

Because the release package ID is the same as the official Android build of Amiberry, Android will only update an existing installation when the APK is signed with a compatible key. If signatures differ, the existing installation may need to be removed first.

After installation, use the Android launcher/file picker to configure Amiberry and import your Amiga files. The Android launcher accepts common Amiga formats including ADF/ADZ, DMS, IPF, HDF, ISO/CUE/CHD, LHA/LZX/LZH, UAE configurations and RP9 files.

The app-specific external files directory is normally located below:

```text
/storage/emulated/0/Android/data/com.blitterstudio.amiberry/files/
```

Saved configurations are stored below the app's `Configurations` directory.

On ChromeOS, the port is intended to be used with a physical keyboard and mouse/touchpad. A normal mechanical touchpad click works as a mouse button. A light tap without physically clicking is not converted into an Amiga mouse click.

## Build with Android Studio

Clone the repository:

```bash
git clone https://github.com/Andiweli/Amiberry-ChromeOS.git
cd Amiberry-ChromeOS
```

Open the `android` directory as the project in Android Studio and allow Gradle to sync. Android Studio should use JDK 17 and the SDK/NDK/CMake versions listed above.

The project contains an Android-specific CMake bootstrap that keeps FetchContent and object paths short on Windows. This avoids common Ninja failures caused by deeply nested SDL3/SDL_image dependency paths. Git long-path support is also enabled automatically for the Git processes started by the Android CMake build.

For normal development, select the `debug` build variant and build the APK. The output is typically:

```text
android/app/build/outputs/apk/debug/app-debug.apk
```

## Build from the command line

From the repository root on Windows:

```bat
cd android
gradlew.bat :app:assembleDebug --no-configuration-cache
```

For a release build:

```bat
cd android
gradlew.bat :app:assembleRelease --no-configuration-cache
```

On Unix-like build hosts use `./gradlew` instead of `gradlew.bat`.

A release build is signed only when `android/keystore.properties` exists. Example:

```properties
storeFile=C:/path/to/amiberry-release.jks
storePassword=YOUR_STORE_PASSWORD
keyAlias=YOUR_KEY_ALIAS
keyPassword=YOUR_KEY_PASSWORD
```

Without that file, use the debug APK for local testing or sign the produced release APK using your own Android signing workflow.

The release APK is normally generated below:

```text
android/app/build/outputs/apk/release/
```

## Windows build notes

Android Studio/AGP creates deeply nested `.cxx` paths and SDL3_image adds several nested third-party dependency trees. This fork includes `android/cmake/android-fetchcontent-paths.cmake`, which relocates FetchContent checkouts to a short directory at the root of the same drive as the source tree and reduces `CMAKE_OBJECT_PATH_MAX` so CMake hashes long object paths earlier.

For example, a checkout on drive `E:` will use a directory similar to:

```text
E:/.amiberry-fc/<source-hash>/<ABI>-<build-type>
```

Normally this directory does **not** need to be deleted between builds.

## Legal

This repository is a modified Android/ChromeOS-focused fork of **Amiberry**. The original project is developed by the Amiberry contributors and is based on the WinUAE emulation core.

Amiberry and this fork are distributed under the **GNU General Public License v3.0**. See [LICENSE](LICENSE) for the complete license text. Source modifications distributed from this repository remain subject to those license terms.

No proprietary AmigaOS, Kickstart ROM, Workbench installation or commercial game/software data is provided by this project. Users are responsible for supplying any required ROMs, operating-system files and software themselves and for having the necessary rights to use them.

Amiga and related names, software and trademarks belong to their respective owners. This Android/ChromeOS port is not an official product of those rights holders.

## Upstream

Original Amiberry project: [BlitterStudio/amiberry](https://github.com/BlitterStudio/amiberry)

This repository exists specifically for the Android/ChromeOS port and its platform-specific adaptations.
