import 'package:flutter/services.dart';

class FlutterMacosPermissions {
  static const MethodChannel _channel =
      MethodChannel('flutter_macos_permissions');

  /// Request
  /// Request camera permission
  static Future<bool> requestCamera() async {
    final result = await _channel.invokeMethod<bool>('requestCamera');
    return result ?? false;
  }

  /// Request microphone permission
  static Future<bool> requestMicrophone() async {
    final result = await _channel.invokeMethod<bool>('requestMicrophone');
    return result ?? false;
  }

  /// Request notification permission
  static Future<bool> requestNotification() async {
    final result = await _channel.invokeMethod('requestNotification');
    return result ?? 'authorized';
  }

  /// request location permission
  static Future<bool> requestLocation() async {
    final result = await _channel.invokeMethod('requestLocation');
    return result == 'authorized';
  }

  /// request full disk access permission
  static Future<bool> requestFullDiskAccess() async {
    final result = await _channel.invokeMethod('requestFullDiskAccess');
    return result ?? 'authorized';
  }

  /// request bluetooth permission
  static Future<bool> requestBluetooth() async {
    final result = await _channel.invokeMethod('requestBluetooth');
    return result ?? 'authorized';
  }

  /// request screen recording permission
  static Future<bool> requestScreenRecording() async {
    final result = await _channel.invokeMethod('requestScreenRecording');
    return result == 'authorized';
  }

  /// checking status......
  /// Check if camera permission is granted
  static Future<String> cameraStatus() async {
    final result = await _channel.invokeMethod('cameraStatus');
    return result ?? '';
  }

  /// Check if microphone permission is granted
  static Future microphoneStatus() async {
    final result = await _channel.invokeMethod('microphoneStatus');
    return result ?? '';
  }

  /// Check if notification permission is granted
  static Future<String> notificationStatus() async {
    final result = await _channel.invokeMethod('notificationStatus');
    return result ?? '';
  }

  /// Check if location permission is granted
  static Future<String> locationStatus() async {
    final result = await _channel.invokeMethod('locationStatus');
    return result ?? '';
  }

  /// Check if full disk access permission is granted
  static Future<String> fullDiskAccessStatus() async {
    final result = await _channel.invokeMethod('fullDiskAccessStatus');
    return result ?? '';
  }

  /// Check if screen recording permission is granted
  static Future<String> screenRecordingStatus() async {
    final result = await _channel.invokeMethod('screenRecordingStatus');
    return result ?? '';
  }

  /// Check if bluetooth permission is granted
  static Future<String> bluetoothStatus() async {
    final result = await _channel.invokeMethod('bluetoothStatus');
    return result ?? '';
  }
}