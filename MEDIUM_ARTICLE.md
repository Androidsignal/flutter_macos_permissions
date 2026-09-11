# flutter_macos_permissions for Beginners: Camera, Mic & More Without Writing Swift

You're building a Flutter app for macOS. At some point you need the camera,
or the microphone, or the user's location — and you hit a wall: Flutter has
no built-in permission API for macOS.

So what do most people do? Drop into Xcode, write Swift, hand-roll a
`MethodChannel`, and spend an afternoon in Apple's docs figuring out what
`CLAuthorizationStatus.notDetermined` actually means.

You don't have to. `flutter_macos_permissions` wraps all of that into a
handful of Dart functions. In this tutorial we'll go from zero to a working
permissions screen, step by step.

## What we're building

By the end of this article you'll have a simple Flutter macOS app with one
button: tap it, the system camera-permission dialog pops up, and the screen
updates to show whether you said yes or no. The same pattern works for all
eight permissions this package supports — Camera, Microphone,
Notifications, Location, Bluetooth, Calendar, Screen Recording, and Full
Disk Access.

## Step 1: Add the package

Open `pubspec.yaml` and add:

```yaml
dependencies:
  flutter_macos_permissions: <latest_version>
```

Then run:

```
flutter pub get
```

## Step 2: Ask for a permission

This is the entire API surface for one permission:

```dart
import 'package:flutter_macos_permissions/flutter_macos_permissions.dart';

final status = await FlutterMacosPermissions.requestCamera();

if (status.isGranted) {
  print('Camera is ready!');
} else {
  print('User said no.');
}
```

`requestCamera()` shows the native macOS dialog (only if the user hasn't
answered before) and hands you back the result. No `MethodChannel`, no
platform folders to touch.

## Step 3: Understand what you get back

Every request/status call returns a `FlutterMacosPermissionStatus` — not a
raw `bool`, not a raw `String`:

```dart
enum FlutterMacosPermissionStatus {
  authorized, authorizedAlways, authorizedWhenInUse, // granted
  denied, restricted, notDetermined,                 // not granted
  provisional, writeOnly,                             // partially granted
  ephemeral, unsupported, unknown,                    // edge cases
}
```

That's 11 possible states — more than you'll ever want to `switch` on by
hand. So don't. Use the one property that matters:

```dart
if (status.isGranted) {
  // authorized, authorizedAlways, authorizedWhenInUse,
  // provisional, or writeOnly — treat all of these as "go ahead"
}
```

## Step 4: Build a minimal permissions screen

Here's a complete, runnable example — a button that requests camera access
and a text widget that shows the result:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_macos_permissions/flutter_macos_permissions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CameraDemo());
  }
}

class CameraDemo extends StatefulWidget {
  const CameraDemo({super.key});

  @override
  State<CameraDemo> createState() => _CameraDemoState();
}

class _CameraDemoState extends State<CameraDemo> {
  String result = 'Not asked yet';

  Future<void> _askForCamera() async {
    final status = await FlutterMacosPermissions.requestCamera();
    setState(() => result = status.isGranted ? 'Granted ✅' : 'Denied ❌');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Permission Demo')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(result, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _askForCamera,
              child: const Text('Request Camera'),
            ),
          ],
        ),
      ),
    );
  }
}
```

Run it with `flutter run -d macos`. Tap the button — nothing happens yet.
That's expected, and it's the step almost everyone trips on first. Keep
reading.

## Step 5: Tell macOS *why* your app wants access

macOS refuses to show any permission dialog until your app declares a
reason. Skip this and `request*()` silently does nothing — no crash, no
error, no dialog.

Open `macos/Runner/Info.plist` and add:

```xml
<key>NSCameraUsageDescription</key>
<string>This app needs your camera to take photos.</string>
```

Every permission has its own key:

* **Camera** — `NSCameraUsageDescription`
* **Microphone** — `NSMicrophoneUsageDescription`
* **Location** — `NSLocationWhenInUseUsageDescription`, `NSLocationAlwaysUsageDescription`
* **Bluetooth** — `NSBluetoothAlwaysUsageDescription`
* **Calendar** — `NSCalendarsUsageDescription` (pre-macOS 14) + `NSCalendarsFullAccessUsageDescription` / `NSCalendarsWriteOnlyAccessUsageDescription` (macOS 14+)
* **Full Disk Access** — `NSDocumentsFolderUsageDescription`
* **Screen Recording** — `NSScreenCaptureDescription`
* **Notifications** — none required

## Step 6: Turn on the matching entitlement

Flutter's macOS template ships with App Sandbox enabled by default. If
`com.apple.security.app-sandbox` is `true` in your entitlements files, the
sandbox blocks each API *before* macOS would even consider showing a
dialog — so Step 5 alone isn't enough.

Open **both** `macos/Runner/DebugProfile.entitlements` and
`macos/Runner/Release.entitlements`, and add:

```xml
<key>com.apple.security.device.camera</key>
<true/>
```

* **Camera** — `com.apple.security.device.camera`
* **Microphone** — `com.apple.security.device.microphone`
* **Location** — `com.apple.security.personal-information.location`
* **Bluetooth** — `com.apple.security.device.bluetooth`
* **Calendar** — `com.apple.security.personal-information.calendars`

Both files — Debug so `flutter run` works while you're developing, Release
so your shipped build works too. Then:

```
flutter clean
flutter run -d macos
```

Entitlements only get re-signed on a full build, so a hot restart won't
pick up the change.

## Step 7: Run it again

Tap "Request Camera" now — the native macOS dialog appears, and `result`
updates to "Granted ✅" or "Denied ❌" depending on what you click.

## Gotcha: "I fixed my setup but it still says denied"

If you tested before finishing Steps 5–6, macOS already recorded a denial
for your bundle ID. It won't re-prompt just because the config is correct
now. Reset the cached decision:

```
tccutil reset Camera your.app.bundle.id
```

Swap `Camera` for whichever permission you're testing (`Bluetooth`,
`Location`, `Calendar`, …). Find your bundle ID in
`macos/Runner/Configs/AppInfo.xcconfig`.

## The one permission that works differently: Full Disk Access

Apple doesn't allow *any* app — this plugin included — to trigger a Full
Disk Access prompt automatically. It's a platform rule, not a plugin
limitation. `requestFullDiskAccess()` checks the current status and opens
System Settings so the user can flip it on by hand. Design your UI around
that instead of expecting a popup.

## Recap

- `requestCamera()`, `requestMicrophone()`, `requestLocation()`, and 5 more
  — same two-method pattern (`request<X>()` / `<x>Status()`) for every
  permission.
- Always branch on `status.isGranted`, never compare raw strings.
- Setup is two files: `Info.plist` (why you want it) + entitlements
  (whether you're allowed to ask). Both required if your app is sandboxed.
- Denied once during testing? `tccutil reset` clears it.

## Try the full example

The package repo includes a complete demo with all 8 permissions wired to
buttons — good starting point to copy from:
[`example/lib/main.dart`](https://github.com/Androidsignal/flutter_macos_permissions/blob/main/example/lib/main.dart)

If this saved you an afternoon of Swift, a clap helps other Flutter
developers find it. Questions or bugs? Open an issue on
[GitHub](https://github.com/Androidsignal/flutter_macos_permissions/issues).
