import 'package:flutter_macos_permissions/flutter_macos_permission_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterMacosPermissionStatus.fromNative', () {
    const cases = {
      'authorized': FlutterMacosPermissionStatus.authorized,
      'authorizedAlways': FlutterMacosPermissionStatus.authorizedAlways,
      'authorizedWhenInUse': FlutterMacosPermissionStatus.authorizedWhenInUse,
      'denied': FlutterMacosPermissionStatus.denied,
      'restricted': FlutterMacosPermissionStatus.restricted,
      'notDetermined': FlutterMacosPermissionStatus.notDetermined,
      'not_determined': FlutterMacosPermissionStatus.notDetermined,
      'provisional': FlutterMacosPermissionStatus.provisional,
      'ephemeral': FlutterMacosPermissionStatus.ephemeral,
      'writeOnly': FlutterMacosPermissionStatus.writeOnly,
      'unsupported': FlutterMacosPermissionStatus.unsupported,
      'something-unexpected': FlutterMacosPermissionStatus.unknown,
      null: FlutterMacosPermissionStatus.unknown,
    };

    cases.forEach((native, expected) {
      test('maps "$native" to $expected', () {
        expect(FlutterMacosPermissionStatus.fromNative(native), expected);
      });
    });
  });

  group('FlutterMacosPermissionStatus.fromGranted', () {
    test('true maps to authorized', () {
      expect(
        FlutterMacosPermissionStatus.fromGranted(true),
        FlutterMacosPermissionStatus.authorized,
      );
    });

    test('false maps to denied', () {
      expect(
        FlutterMacosPermissionStatus.fromGranted(false),
        FlutterMacosPermissionStatus.denied,
      );
    });
  });

  group('isGranted', () {
    test('is true for granting states', () {
      expect(FlutterMacosPermissionStatus.authorized.isGranted, isTrue);
      expect(FlutterMacosPermissionStatus.authorizedAlways.isGranted, isTrue);
      expect(
        FlutterMacosPermissionStatus.authorizedWhenInUse.isGranted,
        isTrue,
      );
      expect(FlutterMacosPermissionStatus.provisional.isGranted, isTrue);
      expect(FlutterMacosPermissionStatus.writeOnly.isGranted, isTrue);
    });

    test('is false for non-granting states', () {
      expect(FlutterMacosPermissionStatus.denied.isGranted, isFalse);
      expect(FlutterMacosPermissionStatus.restricted.isGranted, isFalse);
      expect(FlutterMacosPermissionStatus.notDetermined.isGranted, isFalse);
      expect(FlutterMacosPermissionStatus.ephemeral.isGranted, isFalse);
      expect(FlutterMacosPermissionStatus.unsupported.isGranted, isFalse);
      expect(FlutterMacosPermissionStatus.unknown.isGranted, isFalse);
    });
  });
}
