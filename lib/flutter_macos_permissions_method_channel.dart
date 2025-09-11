import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_macos_permissions_platform_interface.dart';

/// An implementation of [FlutterMacosPermissionsPlatform] that uses method channels.
class MethodChannelFlutterMacosPermissions extends FlutterMacosPermissionsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_macos_permissions');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
