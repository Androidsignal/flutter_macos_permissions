import Cocoa
import FlutterMacOS
import AVFoundation
import UserNotifications

public class FlutterMacosPermissionsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_macos_permissions", binaryMessenger: registrar.messenger)
    let instance = FlutterMacosPermissionsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      // REQUEST
      case "requestCamera":
        AVCaptureDevice.requestAccess(for: .video) { granted in
          result(granted)
        }

      case "requestMicrophone":
        AVCaptureDevice.requestAccess(for: .audio) { granted in
          result(granted)
        }

//       case "requestNotification":
//         UNUserNotificationCenter.current().getNotificationSettings { settings in
//           switch settings.authorizationStatus {
//           case .notDetermined:
//             // Request permission
//             UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
//               DispatchQueue.main.async {
//                 result(granted ? "authorized" : "denied")
//               }
//             }
//           case .denied:
//             // Open system notification settings
//             self.openNotificationSettings()
//             DispatchQueue.main.async { result("denied") }
//           case .authorized, .provisional, .ephemeral:
//             DispatchQueue.main.async { result("authorized") }
//           @unknown default:
//             DispatchQueue.main.async {
//               result(FlutterError(code: "notif_error", message: "Unknown notification status", details: nil))
//             }
//           }
//         }

             case "requestNotification":
                 UNUserNotificationCenter.current().getNotificationSettings { settings in
                     switch settings.authorizationStatus {
                     case .notDetermined:
                         // Request permission
                         UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
                             DispatchQueue.main.async {
                                 result(granted) // <-- returns Bool
                             }
                         }
                     case .denied:
                         // Open system notification settings
                         self.openNotificationSettings()
                         DispatchQueue.main.async { result(false) } // denied = false
                     case .authorized, .provisional, .ephemeral:
                         DispatchQueue.main.async { result(true) } // authorized = true
                     @unknown default:
                         DispatchQueue.main.async { result(false) }
                     }
                 }


      // STATUS
      case "cameraStatus":
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        result(self.mapAVStatus(status))

      case "microphoneStatus":
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        result(self.mapAVStatus(status))

      case "notificationStatus":
       UNUserNotificationCenter.current().getNotificationSettings { settings in
                 let status = self.mapUNStatus(settings.authorizationStatus)
                 DispatchQueue.main.async { result(status) }
               }

      default:
        result(FlutterMethodNotImplemented)
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

  private func mapNotificationStatus(_ status: UNAuthorizationStatus) -> String {
    switch status {
    case .authorized: return "authorized"
    case .denied: return "denied"
    case .notDetermined: return "notDetermined"
    case .provisional: return "provisional"
    case .ephemeral: return "ephemeral"
    @unknown default: return "unknown"
    }
  }

  // MARK: - Open macOS Notification Settings
  private func openNotificationSettings() {
    guard let bundleID = Bundle.main.bundleIdentifier,
          let url = URL(string: "x-apple.systempreferences:com.apple.preference.notifications?appID=\(bundleID)") else {
      return
    }
    NSWorkspace.shared.open(url)
  }
}
