@echo off
setlocal
set OUT=%~dp0chromeos_mouse_log.txt
where adb >nul 2>nul
if errorlevel 1 (
  echo adb.exe was not found in PATH.
  echo In Android Studio, use the SDK platform-tools adb.exe or add platform-tools to PATH.
  pause
  exit /b 1
)
echo Clearing old logcat buffer...
adb logcat -c
echo.
echo Reproduce the mouse problem now. Press Ctrl+C when finished.
echo Log file: %OUT%
echo.
adb logcat -v threadtime | findstr /I /C:"SDL" /C:"amiberry" /C:"mouse" /C:"pointer" /C:"capture" > "%OUT%"
