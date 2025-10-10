import 'package:flutter/material.dart';
import 'package:flutter_macos_permissions/flutter_macos_permissions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'macOS Permissions',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PermissionExample(),
    );
  }
}

class PermissionExample extends StatefulWidget {
  const PermissionExample({super.key});

  @override
  State<PermissionExample> createState() => _PermissionExampleState();
}

class _PermissionExampleState extends State<PermissionExample> {
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

  /// Permission Card Widget
  Widget permissionCard(
    String title,
    IconData icon,
    VoidCallback request,
    VoidCallback status,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey, width: 1.5),
      ),
      elevation: 8,
      shadowColor: Colors.black.withAlpha(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black12.withAlpha(10),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: Colors.black87),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: request,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black38,
                    foregroundColor: Colors.white,
                    elevation: 4,
                  ),
                  child: const Text('Request Permission'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: status,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    side: BorderSide(color: Colors.black87, width: 1.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Check Status',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
}
