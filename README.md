[![dashstack_poster](https://github.com/user-attachments/assets/01150ab3-4631-48a2-8c56-5c64d0fd887b)](https://dashstack.notion.site/Ravi-Vithani-e65c362e335d45ef993225687e4aacb8?pvs=143)

#  flutter macos permissions   
A simple Flutter plugin to request Camera, Microphone, and Notification permissions on macOS.

This plugin provides an easy-to-use API using method channels to handle macOS permissions in your Flutter desktop apps.

---

## ✨ Features
🎥 Request Camera permission

🎤 Request Microphone permission

🔔 Request Notification permission

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

Using PriceText in your project is super simple.

You just need to add the widget with an amount and currency type, and it will handle formatting for you.

## Build permission with FlutterMacosPermissions

---
## 🔹 Request permissions
```
 String _status = "Idle";

  void _request(String type) async {
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
      }
      setState(() {
        _status = '$type permission: ${granted ? "Granted" : "Denied"}';
      });
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    }
  }
```
### Build UI buttons
```
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('macOS Permission Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _request('camera'),
              child: const Text('Request Camera'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _request('microphone'),
              child: const Text('Request Microphone'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _request('notification'),
              child: const Text('Request Notification'),
            ),
          ],
        ),
      ),
    );
  }
```
## 📸 Example
|without Any Permission| with Camera Permission | with Microphone Permission | with Notification Permission |
|-------------------|-----------------------------|-----------------------------|-----------------------------|
| ![idel](https://github.com/user-attachments/assets/8e81d7ce-e113-4d13-983d-7d57e18a354f) | ![camera permission](https://github.com/user-attachments/assets/cddb4f6c-55db-450e-8504-23b4613d5dcc)  | ![microphone permission](https://github.com/user-attachments/assets/dc10fdda-8359-4971-b3c3-7f3c0ef3c1c2) | ![Notification permission](https://github.com/user-attachments/assets/a9d2e45d-a7d9-42ee-a4ca-7f4b80bd662c) | 


## 🔹 Check permission status
```
/// Check status (without requesting)
  void _checkStatus(String type) async {
    String status = 'Unknown';
    try {
      switch (type) {
        case 'cameraStatus':
          status = await FlutterMacosPermissions.cameraStatus();
          break;
        case 'microphoneStatus':
          status = await FlutterMacosPermissions.microphoneStatus();
          print('microphone status: $status');
          break;
        case 'notificationStatus':
          status = await FlutterMacosPermissions.notificationStatus();
          print('checking notification status $status');
          break;
      }
      setState(() {
        _status = 'Status $type → $status ';
      });
    } catch (e) {
      setState(() => _status = 'Error while checking $type: $e');
    }
  }
```
### Build UI buttons
```
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('macOS Permission Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             /// CAMERA
            ElevatedButton(
              onPressed: () => _request('camera'),
              child: const Text('Request Camera'),
            ),
            const SizedBox(height: 20),
             /// MICROPHONE
             ElevatedButton(
              onPressed: () => _checkStatus('microphoneStatus'),
              child: const Text('Check Microphone Status'),
            ),
            const SizedBox(height: 20),
            /// NOTIFICATION
             ElevatedButton(
              onPressed: () => _checkStatus('notificationStatus'),
              child: const Text('Check Notification Status'),
            ),
          ],
        ),
      ),
    );
  }
```

## 📸 Example
| Camera Status | Microphone Status | Notification Status |
|---------------|-------------------|---------------------|
| ![Camera](https://github.com/user-attachments/assets/06e1174b-36b9-4968-b7cd-90ae48f8809f) | ![Microphone](https://github.com/user-attachments/assets/e8a3f128-3f53-4988-95cf-21410e4db8d4) | ![Notification](https://github.com/user-attachments/assets/1322040a-29e6-41fe-bd9e-6811641c1776) |


# Bugs and Feedback 
We welcome and appreciate any suggestions you may have for improvement.
For bugs, questions, and discussions please use the [GitHub Issues](https://github.com/Androidsignal/flutter_macos_permissions/issues).

# Acknowledgments 
It extends Flutter’s foundation to provide a ready-to-use, customizable currency formatter widget.While Flutter and intl provide the base, flutter_macos_permissions simplifies the process by combining widgets and formatting logic into a single package you can drop into any app.
 
# Contribution 
The DashStack team enthusiastically welcomes contributions and project participation!
There are a bunch of things you can do if you want to contribute!
The Contributor Guide has all the information you need for everything from reporting bugs to contributing new features.
  
# Credits 
`flutter_macos_permissions` is owned and maintained by the `Dashstack Infotech`.
Follow us for updates and new releases 🚀.
