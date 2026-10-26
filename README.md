# BT Speaker Toggle

Connect or disconnect a paired Bluetooth speaker from a TV, in one press. The TV's own Bluetooth settings offer
Connect and Unpair for a speaker but no Disconnect. BT Speaker Toggle lists the paired speakers and headphones, each
with its state, and OK on one connects it or, when it is connected, disconnects it. Nothing is unpaired.

Made on a Philips UHD Android TV (TPV, MediaTek), Android 14, with a JBL speaker: connect and disconnect on the real
remote, and the sound moved as expected. Other firmware is untested.

| Row | What it does |
|---|---|
| **Each paired speaker or headphones** | Shows Connected or Not connected. OK connects or disconnects it; the row says Working... until Android reports the change. A speaker that is switched off stays Not connected. |

Android's public API has neither call, so the app uses the audio profile's own connect and disconnect, which a normal
app may call with the Nearby devices permission. It acts on classic Bluetooth audio (A2DP) only. A speaker may
reconnect by itself when it is switched on, as it does without this app.

## Install

Build it from source and sideload it; no prebuilt APK is published.

```
TV_HOST=<tv ip> ./install.sh
```

It needs JDK 17, the Android SDK (`ANDROID_HOME`) and `adb`, and the TV's network debugging on while it runs. It
builds the app, installs it, grants the permission and opens it. Turn network debugging off afterwards.

## Permissions

| Permission | Why |
|---|---|
| Nearby devices (`BLUETOOTH_CONNECT`, Android 12+) | To list paired devices and connect or disconnect them. Granted by `install.sh`; otherwise the app asks once. |
| Bluetooth (`BLUETOOTH`, Android 11 and older) | The same on older versions, granted at install. |

No scanning, no location, no internet permission: nothing leaves the TV. No background service, accessibility
service, telemetry, ads, accounts or libraries.

## With Clean Your TV

It declares a module card for the [Clean Your TV](https://github.com/Gathin23/cleanyourtv) launcher, so its tile can
show on that Home screen. The same app also lives in that repo as the Bluetooth Connect add-on; this repository is an
independent copy under a new name and package, so the two do not share an app id. On any other Android TV home it is
an ordinary app.

## Licence

MIT, see [LICENSE](LICENSE).
