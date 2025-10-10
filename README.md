[![dashstack_poster](https://github.com/user-attachments/assets/01150ab3-4631-48a2-8c56-5c64d0fd887b)](https://dashstack.notion.site/Ravi-Vithani-e65c362e335d45ef993225687e4aacb8?pvs=143)

#  flutter macos permissions   
A simple Flutter plugin to request Camera, Microphone, Notification ,Location ,FullDiskAccess ,Bluetooth and Screen & system audio recording permissions on macOS.

This plugin provides an easy-to-use API using method channels to handle macOS permissions in your Flutter desktop apps.

## ✨ Features
🎥 Request Camera permission

🎤 Request Microphone permission

🔔 Request Notification permission

🌍 Request Location permission

🅱 Request Bluetooth permission

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
 * You can request permissions for Camera, Microphone, Notifications ,Location ,Screen & system audio recording ,FullDiskAccess and Bluetooth :

```
 String status = "Idle";

  /// Request Permission
   void request(String type) async {
    bool granted = false;
    try {
      switch (type) {
        case 'camera':
          granted = await FlutterMacosPermissions.requestCamera();
          break;
        case 'microphone':
          granted = await FlutterMacosPermissions.requestMicrophone();
          break;
        case 'notification':
          granted = await FlutterMacosPermissions.requestNotification();
          break;
        case 'requestLocation':
          granted = await FlutterMacosPermissions.requestLocation();
          break;
        case 'requestFullDiskAccess':
          granted = await FlutterMacosPermissions.requestFullDiskAccess();
          print('fullDiskAccess request $granted');
          break;
        case 'requestScreenRecording':
          granted = await FlutterMacosPermissions.requestScreenRecording();
          break;
        case 'requestBluetooth':
          granted = await FlutterMacosPermissions.requestBluetooth();
          break;
      }
      setState(() {
        status = 'Requested $type → ${granted ? "Granted" : "Denied"}';
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
* Status will return one of the following: authorized, denied, restricted, notDetermined.

```
/// Check Permission Status
 void checkStatus(String type) async {
    String status = 'Unknown';
    try {
      switch (type) {
        case 'cameraStatus':
          status = await FlutterMacosPermissions.cameraStatus();
          break;
        case 'microphoneStatus':
          status = await FlutterMacosPermissions.microphoneStatus();
          break;
        case 'notificationStatus':
          status = await FlutterMacosPermissions.notificationStatus();
          break;
        case 'locationStatus':
          status = await FlutterMacosPermissions.locationStatus();
          break;
        case 'fullDiskAccessStatus':
          status = await FlutterMacosPermissions.fullDiskAccessStatus();
          break;
        case 'screenRecordingStatus':
          status = await FlutterMacosPermissions.screenRecordingStatus();
          break;
        case 'bluetoothStatus':
          status = await FlutterMacosPermissions.bluetoothStatus();
          break;
      }
      setState(() {
        this.status = 'Status $type → $status';
      });
    } catch (e) {
      setState(() => this.status = 'Error: $e');
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
* The table below shows the available permissions, their method calls, possible status values, and the System Preferences location that can be opened if the user has denied access.

| Permission        | Request Permission                                     | Status Permission                                     | Possible Status Values                                | Opens in System Preferences → Privacy & Security |
| ----------------- | ----------------------------------------------- | ---------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------ |
| **Camera**        | `FlutterMacosPermissions.requestCamera()`       | `FlutterMacosPermissions.cameraStatus()`       | `authorized`, `denied`, `restricted`, `notDetermined` | Camera                                           |
| **Microphone**    | `FlutterMacosPermissions.requestMicrophone()`   | `FlutterMacosPermissions.microphoneStatus()`   | `authorized`, `denied`, `restricted`, `notDetermined` | Microphone                                       |
| **Notifications** | `FlutterMacosPermissions.requestNotification()` | `FlutterMacosPermissions.notificationStatus()` | `authorized`, `denied`, `notDetermined`               | Notifications                                    |
| **Location**      | `FlutterMacosPermissions.requestLocation()`     | `FlutterMacosPermissions.locationStatus()`     | `authorized`, `denied`, `restricted`, `notDetermined` | Location Services                                |
| **Screen & system audio recording**     | `FlutterMacosPermissions.requestScreenRecording()`   | `FlutterMacosPermissions.screenRecordingStatus()`  | `authorized`, `denied`, `restricted`, `notDetermined` | Screen & system audio recording|
| **Bluetooth**     | `FlutterMacosPermissions.requestBluetooth()`   | `FlutterMacosPermissions.bluetoothStatus()`  | `authorized`, `denied`, `restricted`, `notDetermined` | Bluetooth                                           |
| **FullDiskAccess**     | `FlutterMacosPermissions.requestFullDiskAccess()`   | `FlutterMacosPermissions.fullDiskAccessStatus()`  | `authorized`, `denied`, `restricted`, `notDetermined` | Full Disk Access                     |

# Bugs and Feedback 
We welcome and appreciate any suggestions you may have for improvement.
For bugs, questions, and discussions please use the [GitHub Issues](https://github.com/Androidsignal/flutter_macos_permissions/issues).

# Acknowledgments 
It extends Flutter’s foundation to provide a ready-to-use, customizable currency formatter widget.While Flutter and intl provide the base, `flutter_macos_permissions` simplifies the process by combining widgets and formatting logic into a single package you can drop into any app.
 
# Contribution 
The DashStack team enthusiastically welcomes contributions and project participation!
There are a bunch of things you can do if you want to contribute!
The Contributor Guide has all the information you need for everything from reporting bugs to contributing new features.
  
# Credits 
`flutter_macos_permissions` is owned and maintained by the `Dashstack Infotech,Surat`.
Follow us for updates and new releases 🚀.
