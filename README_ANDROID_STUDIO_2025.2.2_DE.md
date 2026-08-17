# Amiberry v8.3.0 – Android Studio 2025.2.2 / ChromeOS

Dieses Paket bereitet den **offiziellen Amiberry-v8.3.0-Quellstand** von BlitterStudio reproduzierbar für **Android Studio 2025.2.2 (Otter 2 Feature Drop)** vor.

## Warum überhaupt eine Anpassung nötig ist

Der offizielle v8.3.0-Tag verwendet aktuell:

- Android Gradle Plugin **9.3.1**
- Gradle **9.6.1**
- Kotlin **2.3.20**
- compileSdk / targetSdk **36**
- minSdk **29**
- NDK **29.0.14206865**
- ABI **arm64-v8a** und **x86_64**
- SDL3 **3.4.14** für Android

Android Studio **2025.2.2** unterstützt AGP nur bis **8.13**. Deshalb ändert dieses Paket ausschließlich:

- AGP **9.3.1 → 8.13.2**
- Gradle **9.6.1 → 8.13**

Kotlin 2.3 bleibt erhalten. AGP 8.13.2 enthält ausdrücklich Unterstützung für Kotlin 2.3. API 36 bleibt ebenfalls erhalten.

## ChromeOS-Maus

Amiberry v8.3.0 enthält den entscheidenden ChromeOS-Fix bereits offiziell in `SDLSurface.java`:

- echte physische Maustasten werden über `ACTION_BUTTON_PRESS` / `ACTION_BUTTON_RELEASE` geführt;
- `ACTION_DOWN` / `ACTION_UP` dienen nur noch als Fallback;
- dadurch kann ein von ChromeOS während eines langen Tastendrucks erzeugtes Lifecycle-`ACTION_UP` die gehaltene linke Maustaste nicht mehr vorzeitig lösen;
- relative Mausbewegung läuft über Android Pointer Capture / `SOURCE_MOUSE_RELATIVE`;
- native SDL3-Mausevents werden anschließend von Amiberry verarbeitet.

Deshalb wird in diesem Paket **kein zusätzlicher Maus-Hack** eingebaut. Das ist absichtlich so: zuerst wird der inzwischen upstream behobene und getestete Pfad unverändert auf deinem Chromebook geprüft.

## Paket erstellen

Unter Windows einfach starten:

`prepare_amiberry_8.3.0_androidstudio2025.bat`

Das Skript:

1. lädt exakt den offiziellen Tag `v8.3.0`;
2. prüft Versions- und ChromeOS-Mausmarker im Quellcode;
3. setzt AGP 8.13.2 und Gradle 8.13;
4. übernimmt sonst den offiziellen Quellstand unverändert;
5. erzeugt `Amiberry-8.3.0-AndroidStudio-2025.2.2-ChromeOS.zip`.

## In Android Studio öffnen

Im erzeugten Quellbaum den Ordner **`android`** als Projekt öffnen.

Empfohlene lokale Toolchain:

- Android Studio 2025.2.2
- Gradle JDK 17
- Android SDK Platform 36
- Android SDK Build-Tools 35.0.0 oder neuer
- CMake 3.22.1
- NDK 29.0.14206865

Der NDK-Pin wird bewusst nicht auf den AGP-Standard-NDK zurückgesetzt, weil v8.3.0 selbst mit NDK 29.0.14206865 definiert ist.

## Erster Build

Für die erste Chromebook-Prüfung ist ein Debug-Build sinnvoll:

`gradlew.bat :app:assembleDebug`

Die Debug-Variante verwendet den Paket-Suffix `.debug` und kollidiert damit nicht mit einer normalen Release-Installation.

## Was zuerst getestet werden soll

Siehe `CHROMEOS_MOUSE_TESTPLAN_DE.md`.
