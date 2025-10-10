import Cocoa
import FlutterMacOS
import AVFoundation
import UserNotifications
import CoreLocation
import CoreBluetooth
import ScreenCaptureKit
import FileProvider

public class FlutterMacosPermissionsPlugin: NSObject, FlutterPlugin, CLLocationManagerDelegate, CBCentralManagerDelegate {

    // MARK: - Properties
    private var locationManager: CLLocationManager?
    private var locationResult: FlutterResult?

    private var bluetoothManager: CBCentralManager?
    private var bluetoothResult: FlutterResult?


    // MARK: - Register Plugin
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_macos_permissions", binaryMessenger: registrar.messenger)
        let instance = FlutterMacosPermissionsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    // MARK: - Handle Calls
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {

        // Camera
        case "requestCamera":
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async { result(granted) }
            }
        case "cameraStatus":
            result(self.mapAVStatus(AVCaptureDevice.authorizationStatus(for: .video)))

        // Microphone
        case "requestMicrophone":
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                DispatchQueue.main.async { result(granted) }
            }
        case "microphoneStatus":
            result(self.mapAVStatus(AVCaptureDevice.authorizationStatus(for: .audio)))

        // Notifications
        case "requestNotification":
            self.requestNotificationPermission(result: result)
        case "notificationStatus":
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                let status = self.mapUNStatus(settings.authorizationStatus)
                DispatchQueue.main.async { result(status) }
            }

        // Location
        case "requestLocation":
            self.requestLocationPermission(result: result)
        case "locationStatus":
            result(self.mapCLStatus(CLLocationManager.authorizationStatus()))

        // Full Disk Access
        case "requestFullDiskAccess":
            self.requestFullDiskAccess(result: result)
        case "fullDiskAccessStatus":
            result(mapFDAStatus())

        // Screen Recording
        case "requestScreenRecording":
            self.requestScreenRecordingPermission(result: result)
        case "screenRecordingStatus":
            result(self.checkScreenRecordingStatus() ? "authorized" : "denied")

        // Bluetooth
        case "requestBluetooth":
            self.requestBluetoothPermission(result: result)
        case "bluetoothStatus":
            result(self.checkBluetoothStatus())

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - Camera & Microphone
    private func mapAVStatus(_ status: AVAuthorizationStatus) -> String {
        switch status {
        case .authorized: return "authorized"
        case .denied: return "denied"
        case .restricted: return "restricted"
        case .notDetermined: return "notDetermined"
        @unknown default: return "unknown"
        }
    }

    // MARK: - Location
    private func requestLocationPermission(result: @escaping FlutterResult) {
        locationResult = result
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestWhenInUseAuthorization()
        case .denied, .restricted:
            showLocationAlert()
            result("denied")
        case .authorizedAlways, .authorizedWhenInUse:
            result("authorized")
        @unknown default:
            result("unknown")
        }
    }
    // CLLocationManagerDelegate method
    @objc public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let result = locationResult else { return }
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            result("authorized")
        case .denied, .restricted:
            showLocationAlert()
            result("denied")
        case .notDetermined:
            result("notDetermined")
        @unknown default:
            result("unknown")
        }
        locationResult = nil
    }
    // Map CLLocationManager authorization status to string
    private func mapCLStatus(_ status: CLAuthorizationStatus) -> String {
        switch status {
        case .authorizedAlways: return "authorizedAlways"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .denied: return "denied"
        case .restricted: return "restricted"
        case .notDetermined: return "notDetermined"
        @unknown default: return "unknown"
        }
    }
    // Show alert guiding user to open Settings for Location permission
    private func showLocationAlert() {
        let alert = NSAlert()
        alert.messageText = "Location Permission Needed"
        alert.informativeText = "Please enable location access in System Settings → Privacy & Security → Location Services."
        alert.addButton(withTitle: "Open Settings")
        alert.addButton(withTitle: "Cancel")
        if alert.runModal() == .alertFirstButtonReturn {
            if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_LocationServices") {
                NSWorkspace.shared.open(url)
            }
        }
    }

    // MARK: - Notifications
    private func requestNotificationPermission(result: @escaping FlutterResult) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
                    DispatchQueue.main.async { result(granted) }
                }
            case .denied:
                DispatchQueue.main.async {
                    self.openNotificationSettings()
                    result("denied")
                }
            default:
                DispatchQueue.main.async { result("authorized") }
            }
        }
    }
    // Open System Settings to the app's notification settings
    private func openNotificationSettings() {
        guard let bundleID = Bundle.main.bundleIdentifier,
              let url = URL(string: "x-apple.systempreferences:com.apple.preference.notifications?appID=\(bundleID)") else { return }
        NSWorkspace.shared.open(url)
    }

    private func mapUNStatus(_ status: UNAuthorizationStatus) -> String {
        switch status {
        case .authorized: return "authorized"
        case .denied: return "denied"
        case .notDetermined: return "notDetermined"
        case .provisional: return "provisional"
        case .ephemeral: return "ephemeral"
        @unknown default: return "unknown"
        }
    }

// MARK: - Full Disk Access
private func getFullDiskAccessStatus() -> String {
    let protectedPath = "/Library/Application Support/com.apple.TCC/TCC.db"
    let fm = FileManager.default

    // If TCC database is missing (rare), treat as notDetermined
    if !fm.fileExists(atPath: protectedPath) {
        return "notDetermined"
    }

    // If readable → authorized
    if fm.isReadableFile(atPath: protectedPath) {
        return "authorized"
    } else {
        return "denied"
    }
}

/// Maps Full Disk Access status to a string, consistent with other permissions
private func mapFDAStatus() -> String {
    let status = getFullDiskAccessStatus()
    switch status {
    case "authorized": return "authorized"
    case "denied": return "denied"
    case "notDetermined": return "notDetermined"
    default: return "unknown"
    }
}

/// Opens System Settings so user can manually toggle the permission
private func requestFullDiskAccess(result: @escaping FlutterResult) {
    let status = getFullDiskAccessStatus()
    if status == "authorized" {
        // Already authorized
        result(true)
        return
    }

    // Show alert guiding user to enable FDA
    let alert = NSAlert()
    alert.messageText = "Full Disk Access Required"
    alert.informativeText = """
    Please enable Full Disk Access for this app:
    System Settings → Privacy & Security → Full Disk Access

    After enabling, restart the app.
    """
    alert.addButton(withTitle: "Open Settings")
    alert.addButton(withTitle: "Cancel")

    let response = alert.runModal()
    if response == .alertFirstButtonReturn {
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles") {
            NSWorkspace.shared.open(url)
        }
    }

    // Return false because the user still needs to manually toggle the permission
    result(false)
}

    // MARK: - Screen Recording
    private func requestScreenRecordingPermission(result: @escaping FlutterResult) {
        if checkScreenRecordingStatus() {
            result("authorized")
            return
        }
        let alert = NSAlert()
        alert.messageText = "Screen Recording Permission Required"
        alert.informativeText = "Go to System Settings → Privacy & Security → Screen Recording and enable this app."
        alert.addButton(withTitle: "Open Settings")
        alert.addButton(withTitle: "Cancel")
        if alert.runModal() == .alertFirstButtonReturn {
            if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture") {
                NSWorkspace.shared.open(url)
            }
        }
        result("denied")
    }
    // Check if Screen Recording permission is granted
    private func checkScreenRecordingStatus() -> Bool {
        return CGPreflightScreenCaptureAccess()
    }

    // MARK: - Check Bluetooth Status (String)
    private func checkBluetoothStatus() -> String {
        if #available(macOS 11.0, *) {
            switch CBManager.authorization {
            case .allowedAlways:
                return "authorized"
            case .denied, .restricted:
                return "denied"
            case .notDetermined:
                return "not_determined"
            @unknown default:
                return "unknown"
            }
        } else {
            return "unsupported"
        }
    }

    // MARK: - Request Bluetooth Permission (Bool)
  private func requestBluetoothPermission(result: @escaping FlutterResult) {
      if #available(macOS 11.0, *) {
          let status = CBManager.authorization

          switch status {
          case .allowedAlways:
              result(true) // already granted
          case .denied, .restricted:
              // Permission denied → show alert guiding user to open Settings
              let alert = NSAlert()
              alert.messageText = "Bluetooth Permission Needed"
              alert.informativeText = "Please enable Bluetooth access in System Settings → Privacy & Security → Bluetooth."
              alert.addButton(withTitle: "Open Settings")
              alert.addButton(withTitle: "Cancel")

              let response = alert.runModal()
              if response == .alertFirstButtonReturn {
                  // Open general Privacy settings; user must manually click Bluetooth
                  if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Bluetooth") {
                      NSWorkspace.shared.open(url)
                  }
              }
              result(false)

          case .notDetermined:
              // First-time request triggers system dialog
              bluetoothResult = result
              if bluetoothManager == nil {
                  bluetoothManager = CBCentralManager(delegate: self, queue: nil, options: [
                      CBCentralManagerOptionShowPowerAlertKey: true
                  ])
              }
          @unknown default:
              result(false)
          }
      } else {
          result(false) // macOS < 11 not supported
      }
  }

    // MARK: - CBCentralManagerDelegate
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        guard let result = bluetoothResult else { return }

        if #available(macOS 11.0, *) {
            switch central.authorization {
            case .allowedAlways:
                result(true) // user granted permission
            case .denied, .restricted:
                result(false) // user denied permission
            case .notDetermined:
                result(false) // still not determined (rare)
            @unknown default:
                result(false)
            }
        } else {
            result(false)
        }
        // Clear stored result
        bluetoothResult = nil
    }
}