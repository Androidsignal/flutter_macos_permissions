import 'package:flutter/services.dart';

import 'flutter_macos_permission_status.dart';

export 'flutter_macos_permission_status.dart';

class FlutterMacosPermissions {
  static const MethodChannel _channel =
      MethodChannel('flutter_macos_permissions');

  /// Request camera permission
  static Future<FlutterMacosPermissionStatus> requestCamera() async {
    final result = await _channel.invokeMethod<bool>('requestCamera');
    return FlutterMacosPermissionStatus.fromGranted(result ?? false);
  }

  /// Request microphone permission
  static Future<FlutterMacosPermissionStatus> requestMicrophone() async {
    final result = await _channel.invokeMethod<bool>('requestMicrophone');
    return FlutterMacosPermissionStatus.fromGranted(result ?? false);
  }

  /// Request notification permission
  static Future<FlutterMacosPermissionStatus> requestNotification() async {
    final result = await _channel.invokeMethod('requestNotification');
    if (result is bool) return FlutterMacosPermissionStatus.fromGranted(result);
    return FlutterMacosPermissionStatus.fromNative(result as String?);
  }

  /// request location permission
  static Future<FlutterMacosPermissionStatus> requestLocation() async {
    final result = await _channel.invokeMethod<String>('requestLocation');
    return FlutterMacosPermissionStatus.fromNative(result);
  }

  /// request full disk access permission
  static Future<FlutterMacosPermissionStatus> requestFullDiskAccess() async {
    final result = await _channel.invokeMethod<bool>('requestFullDiskAccess');
    return FlutterMacosPermissionStatus.fromGranted(result ?? false);
  }

  /// request bluetooth permission
  static Future<FlutterMacosPermissionStatus> requestBluetooth() async {
    final result = await _channel.invokeMethod<bool>('requestBluetooth');
    return FlutterMacosPermissionStatus.fromGranted(result ?? false);
  }

  /// request screen recording permission
  static Future<FlutterMacosPermissionStatus> requestScreenRecording() async {
    final result = await _channel.invokeMethod<String>(
      'requestScreenRecording',
    );
    return FlutterMacosPermissionStatus.fromNative(result);
  }

  /// Check if camera permission is granted
  static Future<FlutterMacosPermissionStatus> cameraStatus() async {
    final result = await _channel.invokeMethod<String>('cameraStatus');
    return FlutterMacosPermissionStatus.fromNative(result);
  }

  /// Check if microphone permission is granted
  static Future<FlutterMacosPermissionStatus> microphoneStatus() async {
    final result = await _channel.invokeMethod<String>('microphoneStatus');
    return FlutterMacosPermissionStatus.fromNative(result);
  }

  /// Check if notification permission is granted
  static Future<FlutterMacosPermissionStatus> notificationStatus() async {
    final result = await _channel.invokeMethod<String>('notificationStatus');
    return FlutterMacosPermissionStatus.fromNative(result);
  }

  /// Check if location permission is granted
  static Future<FlutterMacosPermissionStatus> locationStatus() async {
    final result = await _channel.invokeMethod<String>('locationStatus');
    return FlutterMacosPermissionStatus.fromNative(result);
  }

  /// Check if full disk access permission is granted
  static Future<FlutterMacosPermissionStatus> fullDiskAccessStatus() async {
    final result = await _channel.invokeMethod<String>(
      'fullDiskAccessStatus',
    );
    return FlutterMacosPermissionStatus.fromNative(result);
  }

  /// Check if screen recording permission is granted
  static Future<FlutterMacosPermissionStatus> screenRecordingStatus() async {
    final result = await _channel.invokeMethod<String>(
      'screenRecordingStatus',
    );
    return FlutterMacosPermissionStatus.fromNative(result);
  }

  /// Check if bluetooth permission is granted
  static Future<FlutterMacosPermissionStatus> bluetoothStatus() async {
    final result = await _channel.invokeMethod<String>('bluetoothStatus');
    return FlutterMacosPermissionStatus.fromNative(result);
  }

  /// request calendar permission
  static Future<FlutterMacosPermissionStatus> requestCalendar() async {
    final result = await _channel.invokeMethod<bool>('requestCalendar');
    return FlutterMacosPermissionStatus.fromGranted(result ?? false);
  }

  /// Check if calendar permission is granted
  static Future<FlutterMacosPermissionStatus> calendarStatus() async {
    final result = await _channel.invokeMethod<String>('calendarStatus');
    return FlutterMacosPermissionStatus.fromNative(result);
  }
}
