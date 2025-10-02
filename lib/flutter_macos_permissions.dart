import 'package:flutter/services.dart';

class FlutterMacosPermissions {
  static const MethodChannel _channel =
      MethodChannel('flutter_macos_permissions');

  /// request
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
    final result = await _channel.invokeMethod<bool>('requestNotification');
    return result ?? false;
  }

  /// request location permission
  static Future<bool> requestLocation() async {
    final result = await _channel.invokeMethod('requestLocation');
    return result == 'authorized';
  }

  /// status
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
}
