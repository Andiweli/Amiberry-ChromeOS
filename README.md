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

<img width="1920" height="1014" alt="amiberry-launcher-1" src="https://github.com/user-attachments/assets/bd2af3eb-9a19-42cb-bea0-6dd2c08c9bfe" />

<img width="1920" height="1080" alt="amiberry-launcher-2" src="https://github.com/user-attachments/assets/2c35e800-1925-4dc2-a504-f8108e3a4005" />

<img width="1920" height="1080" alt="amiberry" src="https://github.com/user-attachments/assets/bf8e3f2f-7db3-4efb-bdb2-533cd0d7ba6c" />

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

## ❤️ Support

If you enjoy this project and would like to support my work, you can make a small contribution via PayPal.

Your support helps me spend more time maintaining existing projects, fixing bugs, improving compatibility, and working on new features.

[![Support via PayPal](https://img.shields.io/badge/Support%20via-PayPal-0070BA?logo=paypal\&logoColor=white)](https://paypal.me/andiweli)

Thank you for your support!

## Legal

This repository is a modified Android/ChromeOS-focused fork of **Amiberry**. The original project is developed by the Amiberry contributors and is based on the WinUAE emulation core.

Amiberry and this fork are distributed under the **GNU General Public License v3.0**. See [LICENSE](LICENSE) for the complete license text. Source modifications distributed from this repository remain subject to those license terms.

No proprietary AmigaOS, Kickstart ROM, Workbench installation or commercial game/software data is provided by this project. Users are responsible for supplying any required ROMs, operating-system files and software themselves and for having the necessary rights to use them.

Amiga and related names, software and trademarks belong to their respective owners. This Android/ChromeOS port is not an official product of those rights holders.

## Upstream

Original Amiberry project: [BlitterStudio/amiberry](https://github.com/BlitterStudio/amiberry)

This repository exists specifically for the Android/ChromeOS port and its platform-specific adaptations.
