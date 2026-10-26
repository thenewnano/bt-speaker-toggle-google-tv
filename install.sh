#!/usr/bin/env bash
# Build BT Speaker Toggle, install it on the TV over ADB and grant it the Nearby devices permission.
#   TV_HOST=<tv ip> ./install.sh        (network debugging on; leave it off afterwards)
#   ./install.sh                        (one device already attached, e.g. over USB)
# Needs JDK 17, the Android SDK (ANDROID_HOME) and adb on PATH.
set -euo pipefail
cd "$(dirname "$0")"
PKG=io.github.thenewnano.btspeakertoggle
[ -f local.properties ] || { [ -n "${ANDROID_HOME:-}" ] && echo "sdk.dir=${ANDROID_HOME//\\//}" > local.properties; } || true
if [ -n "${JAVA_HOME:-}" ]; then export PATH="$JAVA_HOME/bin:$PATH"; fi
./gradlew assembleRelease -q --console=plain

if [ -n "${TV_HOST:-}" ]; then adb connect "$TV_HOST:5555" >/dev/null; fi
adb install -r app/build/outputs/apk/release/app-release.apk
# Nearby devices, so the app lists and switches paired speakers without asking on the TV.
adb shell pm grant "$PKG" android.permission.BLUETOOTH_CONNECT
adb shell am start -n "$PKG/.MainActivity" >/dev/null
echo "Installed. BT Speaker Toggle is open on the TV: OK on a speaker connects or disconnects it."
echo "Turn network debugging off when you are done."
