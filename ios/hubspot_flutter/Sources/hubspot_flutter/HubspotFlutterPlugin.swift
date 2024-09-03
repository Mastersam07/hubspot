import Flutter
import UIKit

public class HubspotFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "hubspot_flutter", binaryMessenger: registrar.messenger())
    let instance = HubspotFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "initialize":
      do {
        try HubspotManager.shared.configure()
        result(nil)
      } catch {
        result(FlutterError(code: "INITIALIZATION_ERROR", message: "Failed to initialize HubSpot SDK", details: error.localizedDescription))
      }
    case "openChat":
      openChat(result: result)
    case "setUserIdentity":
      guard let args = call.arguments as? [String: Any],
            let email = args["email"] as? String,
            let identityToken = args["identityToken"] as? String else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid email or identityToken", details: nil))
        return
      }
      HubspotManager.shared.setUserIdentity(identityToken: identityToken, email: email)
      result(nil)
    case "setChatProperties":
      guard let properties = call.arguments as? [String: String] else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid properties", details: nil))
        return
      }
      HubspotManager.shared.setChatProperties(data: properties)
      result(nil)
    case "logout":
      HubspotManager.shared.clearUserData()
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func openChat(result: FlutterResult) {
    guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
      result(FlutterError(code: "NO_VIEW_CONTROLLER", message: "No root view controller available", details: nil))
      return
    }
    let chatView = HubspotChatView()
    let hostingController = UIHostingController(rootView: chatView)
    rootViewController.present(hostingController, animated: true, completion: nil)
    result(nil)
  }
}
