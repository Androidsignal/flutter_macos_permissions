import 'package:flutter/material.dart';
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

class PermissionExample extends StatefulWidget {
  const PermissionExample({super.key});

  @override
  State<PermissionExample> createState() => _PermissionExampleState();
}

class _PermissionExampleState extends State<PermissionExample> {
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
}
