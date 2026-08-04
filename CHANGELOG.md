# Changelog

All notable changes to the **flutter_macos_permissions** package will be documented in this file.  
This project follows [Semantic Versioning](https://semver.org/).

---
## 2.0.9

- Added Calendar permission support: `FlutterMacosPermissions.requestCalendar()` and
  `calendarStatus()`, backed by EventKit. On macOS 14+ this correctly distinguishes full access
  from the new write-only calendar access tier (`FlutterMacosPermissionStatus.writeOnly`). Add
  `NSCalendarsUsageDescription` (and, for macOS 14+, `NSCalendarsFullAccessUsageDescription` /
  `NSCalendarsWriteOnlyAccessUsageDescription`) to your app's `Info.plist` to use it.
- `FlutterMacosPermissions` methods now return a typed `FlutterMacosPermissionStatus` enum
  (`authorized`, `authorizedAlways`, `authorizedWhenInUse`, `denied`, `restricted`,
  `notDetermined`, `provisional`, `ephemeral`, `writeOnly`, `unsupported`, `unknown`, with an
  `isGranted` getter) instead of a raw `bool`/`String`. Update callers to use `.isGranted` or compare against
  the enum values instead of `true`/`false` or string literals like `'authorized'`. `requestLocation()`
  and `requestScreenRecording()` now surface the full native status (e.g. `authorizedAlways` vs
  `authorizedWhenInUse`, or `notDetermined`) instead of collapsing it to a bool. See the
  "Migrating" section in the README for examples.
- Updated the package for the latest stable Flutter/Dart toolchain (Flutter 3.44, Dart 3.12): bumped
  `environment` constraints, `plugin_platform_interface`, and `flutter_lints` (5.x → 6.x).
- Added Swift Package Manager support for macOS (`macos/flutter_macos_permissions/Package.swift`)
  alongside the existing CocoaPods podspec, matching the current Flutter plugin template layout.
  Native sources moved from `macos/Classes/` to `macos/flutter_macos_permissions/Sources/flutter_macos_permissions/`.
- Removed an unused `fileName` key from `pubspec.yaml` that doesn't apply to native (non-Dart-only)
  plugin implementations.
- Fixed `requestNotification()`, `requestFullDiskAccess()`, and `requestBluetooth()`, which could
  throw a runtime `TypeError` or return the wrong boolean because the native side can respond with
  either a `bool` or a status `String` depending on the permission state, while the Dart side assumed
  one fixed type.
- Removed unused `ScreenCaptureKit` and `FileProvider` imports from the native macOS plugin, and
  raised the podspec's minimum macOS deployment target to `10.15` (required by
  `CGPreflightScreenCaptureAccess`, used for screen-recording status).
- Regenerated the example app's macOS Xcode project (`example/macos/Runner.xcodeproj`), which was
  missing from the repository entirely and prevented the example from building.
- Replaced the example's stale counter-app widget test (checking for a `"Running on:"` text that
  the app never renders) with a test that verifies the actual permissions UI.
- Removed a stray `print()` call from the example app (`avoid_print` lint) and bumped
  `flutter_lints`/`cupertino_icons` in the example.
- Added a unit test suite for the plugin (`test/`), covering the public `FlutterMacosPermissions`
  API and the fixes above.

## 2.0.8

- update Documentation in `README.md`.

## 2.0.7

- Updated `README.md` with usage examples for all newly added permissions to improve better understanding and usage.


## 2.0.6

- Add new permission:Added `Bluetooth permission`,`fullDiskAccess permission` and `screen & system audio recoding permission` support for macOS.
- Updated `README.md` with usage examples for all newly added permissions to improve better understanding and usage.

## 2.0.5

- Update documentation in `README.md` with better user example.

## 2.0.4
- Add new feature: Location permission support for macOS.
- update `README.md` with location permission usage Example for better user understanding.


## 2.0.3
- Updated UI in the example app to showcase permission request and status clearly.
- Updated `README.md` documentation with new example usage with UI screenshots.


## 2.0.2
- Update documentation in `README.md` with better user example.

## 2.0.1
- Add new feature: enhanced permission status handling.

## 2.0.0 
- Update documentation in `README.md` with better usage examples.

## 1.0.0
- Initial release.