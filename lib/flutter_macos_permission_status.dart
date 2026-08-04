/// Strongly-typed result for a macOS permission, mirroring the raw status
/// strings/bools returned by the native side across all permission types.
enum FlutterMacosPermissionStatus {
  authorized,
  authorizedAlways,
  authorizedWhenInUse,
  denied,
  restricted,
  notDetermined,
  provisional,
  ephemeral,
  writeOnly,
  unsupported,
  unknown;

  /// Maps a native status string (e.g. `"authorized"`, `"not_determined"`)
  /// to a [FlutterMacosPermissionStatus]. Unrecognized values map to
  /// [FlutterMacosPermissionStatus.unknown].
  factory FlutterMacosPermissionStatus.fromNative(String? value) {
    switch (value) {
      case 'authorized':
        return FlutterMacosPermissionStatus.authorized;
      case 'authorizedAlways':
        return FlutterMacosPermissionStatus.authorizedAlways;
      case 'authorizedWhenInUse':
        return FlutterMacosPermissionStatus.authorizedWhenInUse;
      case 'denied':
        return FlutterMacosPermissionStatus.denied;
      case 'restricted':
        return FlutterMacosPermissionStatus.restricted;
      case 'notDetermined':
      case 'not_determined':
        return FlutterMacosPermissionStatus.notDetermined;
      case 'provisional':
        return FlutterMacosPermissionStatus.provisional;
      case 'ephemeral':
        return FlutterMacosPermissionStatus.ephemeral;
      case 'writeOnly':
        return FlutterMacosPermissionStatus.writeOnly;
      case 'unsupported':
        return FlutterMacosPermissionStatus.unsupported;
      default:
        return FlutterMacosPermissionStatus.unknown;
    }
  }

  /// Maps a native `bool` request result (`true`/`false`) to
  /// [FlutterMacosPermissionStatus.authorized] or
  /// [FlutterMacosPermissionStatus.denied].
  factory FlutterMacosPermissionStatus.fromGranted(bool granted) => granted
      ? FlutterMacosPermissionStatus.authorized
      : FlutterMacosPermissionStatus.denied;

  /// True for any state that grants access to the underlying resource.
  bool get isGranted =>
      this == FlutterMacosPermissionStatus.authorized ||
      this == FlutterMacosPermissionStatus.authorizedAlways ||
      this == FlutterMacosPermissionStatus.authorizedWhenInUse ||
      this == FlutterMacosPermissionStatus.provisional ||
      this == FlutterMacosPermissionStatus.writeOnly;
}
