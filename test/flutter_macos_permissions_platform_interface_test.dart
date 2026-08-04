import 'package:flutter_macos_permissions/flutter_macos_permissions_method_channel.dart';
import 'package:flutter_macos_permissions/flutter_macos_permissions_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    '$MethodChannelFlutterMacosPermissions is the default instance',
    () {
      expect(
        FlutterMacosPermissionsPlatform.instance,
        isInstanceOf<MethodChannelFlutterMacosPermissions>(),
      );
    },
  );
}
