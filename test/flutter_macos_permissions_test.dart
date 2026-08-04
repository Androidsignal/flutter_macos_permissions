import 'package:flutter/services.dart';
import 'package:flutter_macos_permissions/flutter_macos_permissions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('flutter_macos_permissions');
  final log = <MethodCall>[];
  Object? Function(MethodCall) responder = (_) => null;

  setUp(() {
    log.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      log.add(call);
      return responder(call);
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('requestCamera maps a native bool result to the enum', () async {
    responder = (_) => true;
    expect(
      await FlutterMacosPermissions.requestCamera(),
      FlutterMacosPermissionStatus.authorized,
    );
    expect(log.single.method, 'requestCamera');
  });

  test('requestCamera maps a denied bool result to the enum', () async {
    responder = (_) => false;
    expect(
      await FlutterMacosPermissions.requestCamera(),
      FlutterMacosPermissionStatus.denied,
    );
  });

  test('requestNotification maps a bool grant result to the enum', () async {
    responder = (_) => true;
    expect(
      await FlutterMacosPermissions.requestNotification(),
      FlutterMacosPermissionStatus.authorized,
    );
  });

  test(
    'requestNotification maps a native "denied" string to the enum',
    () async {
      responder = (_) => 'denied';
      expect(
        await FlutterMacosPermissions.requestNotification(),
        FlutterMacosPermissionStatus.denied,
      );
    },
  );

  test('requestLocation preserves richer native states', () async {
    responder = (_) => 'authorizedAlways';
    expect(
      await FlutterMacosPermissions.requestLocation(),
      FlutterMacosPermissionStatus.authorizedAlways,
    );
    expect(log.single.method, 'requestLocation');
  });

  test('requestFullDiskAccess maps the native bool result to the enum',
      () async {
    responder = (_) => false;
    expect(
      await FlutterMacosPermissions.requestFullDiskAccess(),
      FlutterMacosPermissionStatus.denied,
    );
  });

  test('requestBluetooth maps the native bool result to the enum', () async {
    responder = (_) => true;
    expect(
      await FlutterMacosPermissions.requestBluetooth(),
      FlutterMacosPermissionStatus.authorized,
    );
  });

  test('requestScreenRecording maps the native string to the enum', () async {
    responder = (_) => 'authorized';
    expect(
      await FlutterMacosPermissions.requestScreenRecording(),
      FlutterMacosPermissionStatus.authorized,
    );
  });

  test('microphoneStatus maps the native status string to the enum', () async {
    responder = (_) => 'authorized';
    expect(
      await FlutterMacosPermissions.microphoneStatus(),
      FlutterMacosPermissionStatus.authorized,
    );
  });

  test('cameraStatus falls back to unknown when native returns null', () async {
    responder = (_) => null;
    expect(
      await FlutterMacosPermissions.cameraStatus(),
      FlutterMacosPermissionStatus.unknown,
    );
  });

  test('fullDiskAccessStatus maps "notDetermined" to the enum', () async {
    responder = (_) => 'notDetermined';
    expect(
      await FlutterMacosPermissions.fullDiskAccessStatus(),
      FlutterMacosPermissionStatus.notDetermined,
    );
    expect(log.single.method, 'fullDiskAccessStatus');
  });

  test('bluetoothStatus maps the legacy "not_determined" spelling', () async {
    responder = (_) => 'not_determined';
    expect(
      await FlutterMacosPermissions.bluetoothStatus(),
      FlutterMacosPermissionStatus.notDetermined,
    );
  });

  test('requestCalendar maps the native bool result to the enum', () async {
    responder = (_) => true;
    expect(
      await FlutterMacosPermissions.requestCalendar(),
      FlutterMacosPermissionStatus.authorized,
    );
    expect(log.single.method, 'requestCalendar');
  });

  test('calendarStatus maps "writeOnly" to the enum', () async {
    responder = (_) => 'writeOnly';
    expect(
      await FlutterMacosPermissions.calendarStatus(),
      FlutterMacosPermissionStatus.writeOnly,
    );
    expect(log.single.method, 'calendarStatus');
  });
}
