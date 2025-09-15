import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_macos_permissions/flutter_macos_permissions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PermissionExample());
  }
}

// class PermissionExample extends StatefulWidget {
//   const PermissionExample({super.key});
//
//   @override
//   State<PermissionExample> createState() => _PermissionExampleState();
// }
//
// class _PermissionExampleState extends State<PermissionExample> {
//   String _status = "Idle";
//
//   void _request(String type) async {
//     bool granted = false;
//     try {
//       switch (type) {
//         case 'camera':
//           granted = await FlutterMacosPermissions.requestCamera();
//           break;
//         case 'microphone':
//           granted = await FlutterMacosPermissions.requestMicrophone();
//           break;
//         case 'notification':
//           granted = await FlutterMacosPermissions.requestNotification();
//           break;
//       }
//       setState(() {
//         _status = '$type permission: ${granted ? "Granted" : "Denied"}';
//       });
//     } catch (e) {
//       setState(() {
//         _status = 'Error: $e';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('macOS Permission Example')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(_status),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _request('camera'),
//               child: const Text('Request Camera'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _request('microphone'),
//               child: const Text('Request Microphone'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _request('notification'),
//               child: const Text('Request Notification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class PermissionExample extends StatefulWidget {
  const PermissionExample({super.key});

  @override
  State<PermissionExample> createState() => _PermissionExampleState();
}

class _PermissionExampleState extends State<PermissionExample> {
  String _status = "Idle";

  /// Request permission
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
           print('requested notification permission: $granted');
          break;
      }
      setState(() {
        _status = 'Requested $type → ${granted ? "Granted" : "Denied"}';
      });
    } catch (e) {
      setState(() {
        _status = 'Error while requesting $type: $e';
      });
    }
  }

  void _requestNotification(String) async {
    try {
      bool granted = await FlutterMacosPermissions.requestNotification();
      setState(() {
        _status = 'Notification permission → ${granted ? "Granted" : "Denied"}';
      });
    } on PlatformException catch (e) {
      setState(() {
        _status = 'Error requesting notification: ${e.message ?? "unknown"}';
      });
    }
  }


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
      setState(() { _status = 'Status $type → $status ';});
    } catch (e) {
      setState(() => _status = 'Error while checking $type: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('macOS Permission Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),

            /// CAMERA
            ElevatedButton(
              onPressed: () => _request('camera'),
              child: const Text('Request Camera'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _checkStatus('cameraStatus'),
              child: const Text('Check Camera Status'),
            ),
            const SizedBox(height: 20),

            /// MICROPHONE
            ElevatedButton(
              onPressed: () => _request('microphone'),
              child: const Text('Request Microphone'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _checkStatus('microphoneStatus'),
              child: const Text('Check Microphone Status'),
            ),
            const SizedBox(height: 20),

            /// NOTIFICATION
            ElevatedButton(
              onPressed: () => _requestNotification('notification'),
              child: const Text('Request Notification'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _checkStatus('notificationStatus'),
              child: const Text('Check Notification Status'),
            ),
          ],
        ),
      ),
    );
  }
}