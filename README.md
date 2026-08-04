[![dashstack_poster](https://github.com/user-attachments/assets/01150ab3-4631-48a2-8c56-5c64d0fd887b)](https://www.dashstack.tech/)

#  flutter macos permissions   
A simple Flutter plugin to request Camera, Microphone, Notification ,Location ,FullDiskAccess ,Bluetooth ,Calendar and Screen & system audio recording permissions on macOS.

This plugin provides an easy-to-use API using method channels to handle macOS permissions in your Flutter desktop apps.

## Requirements
* Flutter >= 3.27, Dart >= 3.6
* macOS deployment target >= 10.15
* Supports both CocoaPods and Swift Package Manager for macOS plugin integration

## ✨ Features
🎥 Request Camera permission

🎤 Request Microphone permission

🔔 Request Notification permission

🌍 Request Location permission

🅱 Request Bluetooth permission

📅 Request Calendar permission

🖥 Request Screen & system audio recording permission

💾 Check Full Disk Access permission

🔎 Check current permission status

📝 Works with Flutter macOS desktop apps

---
## How to use it ?

### 1. Add dependency
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
 flutter_macos_permissions: <latest_version>
```  

### 2. Install it You can install packages from the command line: 

with pub :
```
$ pub get
```
with Flutter : 
```
$ flutter pub get
```
### 3. Import it

Now in your `Dart` code, you can use :

```
import 'package:flutter_macos_permissions/flutter_macos_permissions.dart';
```

### 4.How to Use it ?

[Sample](https://github.com/Androidsignal/flutter_macos_permissions/blob/main/example/lib/main.dart) app demonstrates how simple the usage of the library actually is.

Using `flutter_macos_permissions` in your project easy to intregate.

## Build permission with FlutterMacosPermissions

## 🔹 Request permissions
 * You can request permissions for Camera, Microphone, Notifications ,Location ,Screen & system audio recording ,FullDiskAccess ,Bluetooth and Calendar :
 * Every `request*()` method returns a `FlutterMacosPermissionStatus` enum (see "Permission status" section below).

```dart
 String status = "Idle";

  /// Request Permission
   void request(String type) async {
    FlutterMacosPermissionStatus result = FlutterMacosPermissionStatus.unknown;
    try {
      switch (type) {
        case 'camera':
          result = await FlutterMacosPermissions.requestCamera();
          break;
        case 'microphone':
          result = await FlutterMacosPermissions.requestMicrophone();
          break;
        case 'notification':
          result = await FlutterMacosPermissions.requestNotification();
          break;
        case 'requestLocation':
          result = await FlutterMacosPermissions.requestLocation();
          break;
        case 'requestFullDiskAccess':
          result = await FlutterMacosPermissions.requestFullDiskAccess();
          break;
        case 'requestScreenRecording':
          result = await FlutterMacosPermissions.requestScreenRecording();
          break;
        case 'requestBluetooth':
          result = await FlutterMacosPermissions.requestBluetooth();
          break;
        case 'requestCalendar':
          result = await FlutterMacosPermissions.requestCalendar();
          break;
      }
      setState(() {
        status = 'Requested $type → ${result.isGranted ? "Granted" : "Denied"} (${result.name})';
      });
    } catch (e) {
      setState(() {
        status = 'Error: $e';
      });
    }
  }
```
### Build UI buttons
```
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MacOS Permissions')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Status Display
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 2, // Border width
                ),
              ),
              child: Text(status, style: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),

            /// camera permission and status
            permissionCard(
              'Camera',
              Icons.camera_alt,
              () => request('camera'),
              () => checkStatus('cameraStatus'),
            ),

            /// microphone permission and status
            permissionCard(
              'Microphone',
              Icons.mic,
              () => request('microphone'),
              () => checkStatus('microphoneStatus'),
            ),

            /// notification permission and status
            permissionCard(
              'Notifications',
              Icons.notifications,
              () => request('notification'),
              () => checkStatus('notificationStatus'),
            ),

            /// location permission and status
            permissionCard(
              'Location',
              Icons.location_on,
              () => request('requestLocation'),
              () => checkStatus('locationStatus'),
            ),

            /// screen recording permission and status
            permissionCard(
              'Screen & system audio recording',
              Icons.screen_share,
              () => request('requestScreenRecording'),
              () => checkStatus('screenRecordingStatus'),
            ),

            /// full disk access permission and status
            permissionCard(
              'Full Disk Access',
              Icons.folder,
              () => request('requestFullDiskAccess'),
              () => checkStatus('fullDiskAccessStatus'),
            ),

            /// bluetooth permission and status
            permissionCard(
              'Bluetooth',
              Icons.bluetooth,
              () => request('requestBluetooth'),
              () => checkStatus('bluetoothStatus'),
            ),

            /// calendar permission and status
            permissionCard(
              'Calendar',
              Icons.calendar_month,
              () => request('requestCalendar'),
              () => checkStatus('calendarStatus'),
            ),
          ],
        ),
      ),
    );
  }
```
## 📸 Example
|without Any Permission| with Camera Permission | 
|-------------------|-----------------------------|
| ![idel](https://github.com/user-attachments/assets/f84bc852-6590-4a02-b1fd-d45d84fe6b63) | ![camera permission](https://github.com/user-attachments/assets/50775195-48ff-40ae-aee0-fe730fce0828) | 

|with Notification Permission | with Location Permission |
|-----------------------------|-----------------------------|
![Notification permission](https://github.com/user-attachments/assets/769e417a-4602-425c-8f31-6657014b19d4) | ![Location permission](https://github.com/user-attachments/assets/3652c490-f736-43db-a4c3-640b1dce77ef) | 

|with Bluetooth Permission | with FullDiskAccess Permission |
|-----------------------------|-----------------------------|
![Notification permission](https://github.com/user-attachments/assets/d874cf7e-50e6-4c8f-b585-48dd7e2d2651) | ![Location permission](https://github.com/user-attachments/assets/9d67abce-0a3b-4a96-bcd7-1bc0f1888059) | 

|with Microphone Permission | Screen & system audio recording Permission |
|-----------------------------|-----------------------------|
| ![microphone permission](https://github.com/user-attachments/assets/c0051a8f-3ea0-48c1-8ccb-c9192bac80ea) | ![Location permission](https://github.com/user-attachments/assets/40bd6bd7-2ace-46ed-a551-9e379c28abcf) | 

## 🔹 Check permission status

* You can also check the current status without requesting and with requesting.
* Every `*Status()` method returns a `FlutterMacosPermissionStatus` enum value (see "Permission status" section below).
* `*Status()` only reads the current OS state — it never shows a system prompt. If it returns
  `notDetermined`, that means the permission was never requested yet; call the matching
  `request*()` method to trigger the actual dialog.

```dart
/// Check Permission Status
 void checkStatus(String type) async {
    FlutterMacosPermissionStatus result = FlutterMacosPermissionStatus.unknown;
    try {
      switch (type) {
        case 'cameraStatus':
          result = await FlutterMacosPermissions.cameraStatus();
          break;
        case 'microphoneStatus':
          result = await FlutterMacosPermissions.microphoneStatus();
          break;
        case 'notificationStatus':
          result = await FlutterMacosPermissions.notificationStatus();
          break;
        case 'locationStatus':
          result = await FlutterMacosPermissions.locationStatus();
          break;
        case 'fullDiskAccessStatus':
          result = await FlutterMacosPermissions.fullDiskAccessStatus();
          break;
        case 'screenRecordingStatus':
          result = await FlutterMacosPermissions.screenRecordingStatus();
          break;
        case 'bluetoothStatus':
          result = await FlutterMacosPermissions.bluetoothStatus();
          break;
        case 'calendarStatus':
          result = await FlutterMacosPermissions.calendarStatus();
          break;
      }
      setState(() {
        status = 'Status $type → ${result.name}';
      });
    } catch (e) {
      setState(() => status = 'Error: $e');
    }
  }
```
### Build UI buttons
```
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MacOS Permissions')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Status Display
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 2, // Border width
                ),
              ),
              child: Text(status, style: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),

            /// camera permission and status
            permissionCard(
              'Camera',
              Icons.camera_alt,
              () => request('camera'),
              () => checkStatus('cameraStatus'),
            ),

            /// microphone permission and status
            permissionCard(
              'Microphone',
              Icons.mic,
              () => request('microphone'),
              () => checkStatus('microphoneStatus'),
            ),

            /// notification permission and status
            permissionCard(
              'Notifications',
              Icons.notifications,
              () => request('notification'),
              () => checkStatus('notificationStatus'),
            ),

            /// location permission and status
            permissionCard(
              'Location',
              Icons.location_on,
              () => request('requestLocation'),
              () => checkStatus('locationStatus'),
            ),

            /// screen recording permission and status
            permissionCard(
              'Screen & system audio recording',
              Icons.screen_share,
              () => request('requestScreenRecording'),
              () => checkStatus('screenRecordingStatus'),
            ),

            /// full disk access permission and status
            permissionCard(
              'Full Disk Access',
              Icons.folder,
              () => request('requestFullDiskAccess'),
              () => checkStatus('fullDiskAccessStatus'),
            ),

            /// bluetooth permission and status
            permissionCard(
              'Bluetooth',
              Icons.bluetooth,
              () => request('requestBluetooth'),
              () => checkStatus('bluetoothStatus'),
            ),

            /// calendar permission and status
            permissionCard(
              'Calendar',
              Icons.calendar_month,
              () => request('requestCalendar'),
              () => checkStatus('calendarStatus'),
            ),
          ],
        ),
      ),
    );
  }
```

## 📸 Example

| Camera Status| Microphone Status  | Screen & system audio recording Status |
|-------------------|-----------------------------|-----------------------------|
| ![Camera](https://github.com/user-attachments/assets/d8312b4a-4b1c-47a3-a526-240cd9d4cbc2) | ![Microphone](https://github.com/user-attachments/assets/a957c261-2139-4793-a4aa-d0daf0c1de42) | ![Screen & system audio recording](https://github.com/user-attachments/assets/60473883-4a2d-4c32-9812-337e93fe353a) |

| Notification Status                                                                              | Location Status                                                                              |
| ------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------- |
| ![Notification](https://github.com/user-attachments/assets/febcedad-004c-4a40-a3e5-ebe3d65fcab3) | ![Location](https://github.com/user-attachments/assets/4d94ff83-6eec-4ba4-b6ef-9658fbabe0b0) |

| Bluetooth Status                                                                                 | FullDiskAccess  Status                                                                       |
| ------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------- |
| ![Bluetooth](https://github.com/user-attachments/assets/ed0353fc-5936-45b2-b189-aab560d931d2)    | ![FullDiskAcess](https://github.com/user-attachments/assets/3c91b4d2-c3ab-4fa6-8e39-58116311e8ee) |

## 📑 Permission Properties
* The table below shows the available permissions, their method calls, possible enum values, and the System Preferences location that can be opened if the user has denied access.

| Permission        | Request Permission                                     | Status Permission                                     | Possible `FlutterMacosPermissionStatus` Values                                | Opens in System Preferences → Privacy & Security |
| ----------------- | ----------------------------------------------- | ---------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------ |
| **Camera**        | `FlutterMacosPermissions.requestCamera()`       | `FlutterMacosPermissions.cameraStatus()`       | `authorized`, `denied`, `restricted`, `notDetermined` | Camera                                           |
| **Microphone**    | `FlutterMacosPermissions.requestMicrophone()`   | `FlutterMacosPermissions.microphoneStatus()`   | `authorized`, `denied`, `restricted`, `notDetermined` | Microphone                                       |
| **Notifications** | `FlutterMacosPermissions.requestNotification()` | `FlutterMacosPermissions.notificationStatus()` | `authorized`, `denied`, `notDetermined`, `provisional`, `ephemeral` | Notifications                                    |
| **Location**      | `FlutterMacosPermissions.requestLocation()`     | `FlutterMacosPermissions.locationStatus()`     | `authorizedAlways`, `authorizedWhenInUse`, `denied`, `restricted`, `notDetermined` | Location Services                                |
| **Screen & system audio recording**     | `FlutterMacosPermissions.requestScreenRecording()`   | `FlutterMacosPermissions.screenRecordingStatus()`  | `authorized`, `denied` | Screen & system audio recording|
| **Bluetooth**     | `FlutterMacosPermissions.requestBluetooth()`   | `FlutterMacosPermissions.bluetoothStatus()`  | `authorized`, `denied`, `notDetermined`, `unsupported`, `unknown` | Bluetooth                                           |
| **FullDiskAccess**     | `FlutterMacosPermissions.requestFullDiskAccess()`   | `FlutterMacosPermissions.fullDiskAccessStatus()`  | `authorized`, `denied`, `notDetermined`, `unknown` | Full Disk Access                     |
| **Calendar**     | `FlutterMacosPermissions.requestCalendar()`   | `FlutterMacosPermissions.calendarStatus()`  | `authorized`, `denied`, `restricted`, `notDetermined`, `writeOnly` | Calendars                     |

> **Calendar requires Info.plist keys.** Add `NSCalendarsUsageDescription` (pre-macOS 14) and,
> for macOS 14+, `NSCalendarsFullAccessUsageDescription` / `NSCalendarsWriteOnlyAccessUsageDescription`
> to your app's `macos/Runner/Info.plist`, or the permission prompt won't appear and the request
> silently fails.
>
> **Sandboxed app?** If `com.apple.security.app-sandbox` is `true` in your
> `macos/Runner/*.entitlements` files (the default Flutter macOS template), you also need
> `com.apple.security.personal-information.calendars` set to `true` there — without it the
> sandbox blocks EventKit outright and the status stays `notDetermined` forever, even after
> you add the Info.plist keys above.

## 🔹 Permission status: `FlutterMacosPermissionStatus`
* All `request*()`/`*Status()` methods return this enum instead of a raw `bool`/`String`, so callers get exhaustive `switch` support and no magic-string comparisons.
* Values: `authorized`, `authorizedAlways`, `authorizedWhenInUse`, `denied`, `restricted`, `notDetermined`, `provisional`, `ephemeral`, `writeOnly`, `unsupported`, `unknown`.
* `isGranted` is `true` for `authorized`, `authorizedAlways`, `authorizedWhenInUse`, `provisional`, and `writeOnly`.
* `writeOnly` is Calendar-specific: on macOS 14+, an app can be granted write-only calendar access (can create events but not read existing ones) without a full-access prompt.

```dart
final status = await FlutterMacosPermissions.fullDiskAccessStatus();
if (status.isGranted) {
  // proceed
} else if (status == FlutterMacosPermissionStatus.notDetermined) {
  await FlutterMacosPermissions.requestFullDiskAccess();
}
```

## ⚠️ Migrating to typed status
Every `request*()` and `*Status()` method now returns `Future<FlutterMacosPermissionStatus>`
instead of `Future<bool>` / `Future<String>`.

```dart
// Before
final bool granted = await FlutterMacosPermissions.requestCamera();
final String status = await FlutterMacosPermissions.cameraStatus();
if (status == 'authorized') { ... }

// After
final FlutterMacosPermissionStatus granted = await FlutterMacosPermissions.requestCamera();
final FlutterMacosPermissionStatus status = await FlutterMacosPermissions.cameraStatus();
if (status.isGranted) { ... }
```

# Bugs and Feedback 
We welcome and appreciate any suggestions you may have for improvement.
For bugs, questions, and discussions please use the [GitHub Issues](https://github.com/Androidsignal/flutter_macos_permissions/issues).

# Acknowledgments 
`flutter_macos_permissions` wraps macOS's native permission APIs (AVFoundation, UserNotifications, CoreLocation, CoreBluetooth, EventKit, and the Screen Recording/Full Disk Access privacy checks) behind a single, simple Dart API so you don't have to write platform channel code by hand.
 
# Contribution 
The DashStack team enthusiastically welcomes contributions and project participation!
There are a bunch of things you can do if you want to contribute!
The Contributor Guide has all the information you need for everything from reporting bugs to contributing new features.
  
# Credits 
`flutter_macos_permissions` is owned and maintained by the `Dashstack Infotech,Surat`.
Follow us for updates and new releases 🚀.
