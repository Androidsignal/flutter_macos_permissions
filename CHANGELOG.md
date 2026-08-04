# Changelog

All notable changes to the **flutter_macos_permissions** package will be documented in this file.  
This project follows [Semantic Versioning](https://semver.org/).

---
## 2.1.0

- Added Calendar permission (`requestCalendar()`, `calendarStatus()`).
- All methods now return a `FlutterMacosPermissionStatus` enum instead of a raw `bool`/`String` —
  use `status.isGranted`. See the README's "Migrating from 2.x" section.
- Added Swift Package Manager support alongside the existing CocoaPods podspec.
- Fixed a wrong Bluetooth entitlement key in the example app, and a bug where
  `requestNotification()`/`requestFullDiskAccess()`/`requestBluetooth()` could crash if the
  native side returned an unexpected type.
- Updated for the latest Flutter/Dart (Flutter 3.44, Dart 3.12) and added a test suite.
- Simplified the README: quick-start example, setup checklist, troubleshooting for the
  "permission dialog never shows" issue.

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