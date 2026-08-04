[![dashstack_poster](https://github.com/user-attachments/assets/01150ab3-4631-48a2-8c56-5c64d0fd887b)](https://www.dashstack.tech/)

# flutter_macos_permissions

Request Camera, Microphone, Notifications, Location, Bluetooth, Calendar, Screen Recording, and
Full Disk Access permissions on macOS — one simple Dart API, no platform-channel code to write.

Requires Flutter >= 3.27, Dart >= 3.6, macOS deployment target >= 10.15.

## Install

```yaml
dependencies:
  flutter_macos_permissions: <latest_version>
```

```
flutter pub get
```

## Quick start

```dart
import 'package:flutter_macos_permissions/flutter_macos_permissions.dart';

final status = await FlutterMacosPermissions.requestCamera();

if (status.isGranted) {
  // camera is available
}
```

Every permission works the same way, two methods each:

* **`request<Permission>()`** — shows the system dialog (only if the user hasn't answered yet)
  and returns the result.
* **`<permission>Status()`** — reads the current state, doesn't show anything.

Both return a `FlutterMacosPermissionStatus` enum — see below.

> **First time using this?** macOS won't show the dialog at all until you add a couple of things
> to your own app. Read the "Setup" section below before you test — this is the #1 source of
> "nothing happens when I call request*()".

## All permissions

Call these as `FlutterMacosPermissions.<method>()`:

| Permission | Request | Status |
| --- | --- | --- |
| Camera | `requestCamera()` | `cameraStatus()` |
| Microphone | `requestMicrophone()` | `microphoneStatus()` |
| Notifications | `requestNotification()` | `notificationStatus()` |
| Location | `requestLocation()` | `locationStatus()` |
| Bluetooth | `requestBluetooth()` | `bluetoothStatus()` |
| Calendar | `requestCalendar()` | `calendarStatus()` |
| Screen Recording | `requestScreenRecording()` | `screenRecordingStatus()` |
| Full Disk Access | `requestFullDiskAccess()` | `fullDiskAccessStatus()` |

Full working app using all eight: [`example/lib/main.dart`](example/lib/main.dart).

## `FlutterMacosPermissionStatus`

```dart
enum FlutterMacosPermissionStatus {
  authorized, authorizedAlways, authorizedWhenInUse, // granted
  denied, restricted, notDetermined,                 // not granted
  provisional, writeOnly,                             // partially granted
  ephemeral, unsupported, unknown,                    // edge cases
}
```

Don't compare against individual values — use `status.isGranted` (`true` for `authorized`,
`authorizedAlways`, `authorizedWhenInUse`, `provisional`, and `writeOnly`):

```dart
final status = await FlutterMacosPermissions.fullDiskAccessStatus();
if (status.isGranted) {
  // proceed
} else if (status == FlutterMacosPermissionStatus.notDetermined) {
  await FlutterMacosPermissions.requestFullDiskAccess();
}
```

## ⚙️ Setup (required)
Add these to **your app**, not this plugin — it can't do it for you.

**1. `macos/Runner/Info.plist`** — one usage-description string per permission you use:

| Permission | Info.plist key(s) |
| --- | --- |
| Camera | `NSCameraUsageDescription` |
| Microphone | `NSMicrophoneUsageDescription` |
| Location | `NSLocationWhenInUseUsageDescription`, `NSLocationAlwaysUsageDescription` |
| Bluetooth | `NSBluetoothAlwaysUsageDescription` |
| Calendar | `NSCalendarsUsageDescription` (pre-macOS 14) + `NSCalendarsFullAccessUsageDescription` / `NSCalendarsWriteOnlyAccessUsageDescription` (macOS 14+) |
| Full Disk Access | `NSDocumentsFolderUsageDescription` |
| Screen Recording | `NSScreenCaptureDescription` |
| Notifications | none required |

Missing the key means the OS drops the request silently — no crash, no dialog, no error.

**2. `macos/Runner/DebugProfile.entitlements` *and* `macos/Runner/Release.entitlements`** — only
if `com.apple.security.app-sandbox` is `true` (the Flutter macOS template default). Without
these, the sandbox blocks the API before macOS would even show a dialog:

| Permission | Entitlement key |
| --- | --- |
| Camera | `com.apple.security.device.camera` |
| Microphone | `com.apple.security.device.microphone` |
| Location | `com.apple.security.personal-information.location` |
| Bluetooth | `com.apple.security.device.bluetooth` |
| Calendar | `com.apple.security.personal-information.calendars` |

Add these to **both** entitlements files (Debug so `flutter run` works, Release for shipped
builds), then `flutter clean` and rebuild — entitlements only get re-signed on a full build.

See `example/macos/Runner/Info.plist` and `example/macos/Runner/*.entitlements` for a complete
working reference.

## Troubleshooting

**Status stuck on `notDetermined`, dialog never shows** — you're missing an Info.plist key or
an entitlement (or both). Check the tables above.

**Status is `denied` and the dialog still won't show, even after fixing the config** — macOS
already recorded a denial for your bundle ID from an earlier attempt, before the config was
right. It won't re-prompt just because you fixed it afterward. Clear the cached decision:
```
tccutil reset Calendar <your.bundle.id>       # or Bluetooth / Location / etc.
```
(bundle id is in `macos/Runner/Configs/AppInfo.xcconfig`, `PRODUCT_BUNDLE_IDENTIFIER`)

## Migrating from 2.x
All methods used to return `Future<bool>` or `Future<String>`. They now return
`Future<FlutterMacosPermissionStatus>`.

```dart
// Before
final bool granted = await FlutterMacosPermissions.requestCamera();
final String status = await FlutterMacosPermissions.cameraStatus();
if (status == 'authorized') { ... }

// After
final status = await FlutterMacosPermissions.requestCamera();
if (status.isGranted) { ... }
```

## Bugs & Credits
Report bugs and ask questions on [GitHub Issues](https://github.com/Androidsignal/flutter_macos_permissions/issues).
Maintained by [Dashstack Infotech, Surat](https://www.dashstack.tech/).
