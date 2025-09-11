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
    case "requestCamera":
      AVCaptureDevice.requestAccess(for: .video) { granted in
        result(granted)
      }

    case "requestMicrophone":
      AVCaptureDevice.requestAccess(for: .audio) { granted in
        result(granted)
      }

    case "requestNotification":
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if let error = error {
          result(FlutterError(code: "notification_error", message: error.localizedDescription, details: nil))
        } else {
          result(granted)
        }
      }

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
