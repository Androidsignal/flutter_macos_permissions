import 'package:flutter/services.dart';

class FlutterMacosPermissions {
  static const MethodChannel _channel = MethodChannel('flutter_macos_permissions');

  static Future<bool> requestCamera() async {
    final result = await _channel.invokeMethod<bool>('requestCamera');
    return result ?? false;
  }

  static Future<bool> requestMicrophone() async {
    final result = await _channel.invokeMethod<bool>('requestMicrophone');
    return result ?? false;
  }

  static Future<bool> requestNotification() async {
    final result = await _channel.invokeMethod<bool>('requestNotification');
    return result ?? false;
  }
}
