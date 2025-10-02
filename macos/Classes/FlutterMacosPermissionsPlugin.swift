import Cocoa
import FlutterMacOS
import AVFoundation
import UserNotifications
import CoreLocation
import Contacts

public class FlutterMacosPermissionsPlugin: NSObject, FlutterPlugin, CLLocationManagerDelegate {

    // MARK: - Properties
    private var locationManager: CLLocationManager?
    private var locationResult: FlutterResult?

    // MARK: - Plugin Registration
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "flutter_macos_permissions",
            binaryMessenger: registrar.messenger
        )
        let instance = FlutterMacosPermissionsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    // MARK: - Handle Method Calls
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {

        case "requestCamera":
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async { result(granted) }
            }

        case "requestMicrophone":
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                DispatchQueue.main.async { result(granted) }
            }

        case "requestNotification":
            requestNotificationPermission(result: result)

        case "requestLocation":
            requestLocationPermission(result: result)

        case "cameraStatus":
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            result(mapAVStatus(status))

        case "microphoneStatus":
            let status = AVCaptureDevice.authorizationStatus(for: .audio)
            result(mapAVStatus(status))

        case "notificationStatus":
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                let status = self.mapUNStatus(settings.authorizationStatus)
                DispatchQueue.main.async { result(status) }
            }

        case "locationStatus":
            let status = CLLocationManager.authorizationStatus()
            result(mapCLStatus(status))

        default:
            result(FlutterMethodNotImplemented)
        }
    }

private func requestLocationPermission(result: @escaping FlutterResult) {
    self.locationResult = result
    let status = CLLocationManager.authorizationStatus()

    switch status {
    case .notDetermined:
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    case .denied, .restricted:
        // Show alert to open system settings
        showLocationAlert()
        result("denied")  // return actual status
    case .authorizedAlways, .authorizedWhenInUse:
        result("authorized")
    @unknown default:
        result("unknown")
    }
}

// Delegate method
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


   private func showLocationAlert() {
       let alert = NSAlert()
       alert.messageText = "Location Permission Needed"
       alert.informativeText = "Location access was denied. Please enable it in System Settings → Privacy → Location Services."
       alert.addButton(withTitle: "Open Settings")
       alert.addButton(withTitle: "Cancel")
       if alert.runModal() == .alertFirstButtonReturn {
           if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_LocationServices") {
               NSWorkspace.shared.open(url)
           }
       }
   }

    // MARK: - Notification Permission
    private func requestNotificationPermission(result: @escaping FlutterResult) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
                    DispatchQueue.main.async { result(granted) }
                }
            case .denied:
                self.openNotificationSettings()
                DispatchQueue.main.async { result(false) }
            case .authorized, .provisional, .ephemeral:
                DispatchQueue.main.async { result(true) }
            @unknown default:
                DispatchQueue.main.async { result(false) }
            }
        }
    }

    // MARK: - Helpers
    private func mapAVStatus(_ status: AVAuthorizationStatus) -> String {
        switch status {
        case .authorized: return "authorized"
        case .denied: return "denied"
        case .restricted: return "restricted"
        case .notDetermined: return "notDetermined"
        @unknown default: return "unknown"
        }
    }

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

    private func openNotificationSettings() {
        guard let bundleID = Bundle.main.bundleIdentifier,
              let url = URL(string: "x-apple.systempreferences:com.apple.preference.notifications?appID=\(bundleID)") else { return }
        NSWorkspace.shared.open(url)
    }

    private func openLocationSettings() {
        guard let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_LocationServices") else { return }
        NSWorkspace.shared.open(url)
    }
}