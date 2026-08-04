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
        status =
            'Requested $type → ${result.isGranted ? "Granted" : "Denied"} (${result.name})';
      });
    } catch (e) {
      setState(() {
        status = 'Error: $e';
      });
    }
  }

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
}
