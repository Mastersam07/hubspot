import Flutter
import SwiftUI
import HubspotMobileSDK

@MainActor
public class HubspotPlugin: NSObject, FlutterPlugin {
  private var rootViewController: UIViewController?
  private var isInitialized = false
  private var logger: FlutterMethodChannel?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "hubspot", binaryMessenger: registrar.messenger())
    let instance = HubspotPlugin()
    instance.logger = FlutterMethodChannel(name: "hubspot_logs", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  private func log(_ message: String) {
    #if DEBUG
    logger?.invokeMethod("log", arguments: message)
    #endif
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    Task {
      await handleAsync(call, result: result)
    }
  }

  private func handleAsync(_ call: FlutterMethodCall, result: @escaping FlutterResult) async {
    switch call.method {
    case "initialize":
      do {
        try await HubspotManager.shared.configure()
        isInitialized = true
        log("HubSpot SDK initialized successfully")
        result(nil)
      } catch {
        log("HubSpot SDK initialization failed: \(error.localizedDescription)")
        result(FlutterError(
          code: "INITIALIZATION_ERROR",
          message: "Failed to initialize HubSpot SDK: \(error.localizedDescription)",
          details: nil
        ))
      }
    case "openChat":
      if !isInitialized {
        result(FlutterError(
          code: "NOT_INITIALIZED",
          message: "HubSpot SDK must be initialized before opening chat",
          details: nil
        ))
        return
      }
      await openChat(result: result)
    case "setUserIdentity":
      if !isInitialized {
        result(FlutterError(
          code: "NOT_INITIALIZED",
          message: "HubSpot SDK must be initialized before setting user identity",
          details: nil
        ))
        return
      }
      
      guard let args = call.arguments as? [String: Any] else {
        result(FlutterError(
          code: "INVALID_ARGUMENT",
          message: "Arguments must be a Map",
          details: nil
        ))
        return
      }
      
      guard let email = args["email"] as? String else {
        result(FlutterError(
          code: "INVALID_ARGUMENT",
          message: "Email is required and must be a String",
          details: nil
        ))
        return
      }
      
      guard let identityToken = args["identityToken"] as? String else {
        result(FlutterError(
          code: "INVALID_ARGUMENT",
          message: "IdentityToken is required and must be a String",
          details: nil
        ))
        return
      }
      
      do {
        await HubspotManager.shared.setUserIdentity(identityToken: identityToken, email: email)
        log("User identity set successfully")
        result(nil)
      } catch {
        log("Failed to set user identity: \(error.localizedDescription)")
        result(FlutterError(
          code: "IDENTITY_ERROR",
          message: "Failed to set user identity: \(error.localizedDescription)",
          details: nil
        ))
      }
    case "setChatProperties":
      if !isInitialized {
        result(FlutterError(
          code: "NOT_INITIALIZED",
          message: "HubSpot SDK must be initialized before setting chat properties",
          details: nil
        ))
        return
      }
      
      guard let args = call.arguments as? [String: Any],
            let properties = args["properties"] as? [String: String] else {
        log("Invalid arguments received: \(String(describing: call.arguments))")
        result(FlutterError(
          code: "INVALID_ARGUMENT",
          message: "Properties must be a Map<String, String>",
          details: nil
        ))
        return
      }
      
      do {
        await HubspotManager.shared.setChatProperties(data: properties)
        log("Chat properties set successfully")
        result(nil)
      } catch {
        log("Failed to set chat properties: \(error.localizedDescription)")
        result(FlutterError(
          code: "PROPERTIES_ERROR",
          message: "Failed to set chat properties: \(error.localizedDescription)",
          details: nil
        ))
      }
    case "logout":
      if !isInitialized {
        result(FlutterError(
          code: "NOT_INITIALIZED",
          message: "HubSpot SDK must be initialized before logging out",
          details: nil
        ))
        return
      }
      
      do {
        await HubspotManager.shared.clearUserData()
        log("User logged out successfully")
        result(nil)
      } catch {
        log("Failed to logout: \(error.localizedDescription)")
        result(FlutterError(
          code: "LOGOUT_ERROR",
          message: "Failed to logout: \(error.localizedDescription)",
          details: nil
        ))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func openChat(result: FlutterResult) async {
    if rootViewController == nil {
      rootViewController = await UIApplication.shared.connectedScenes
        .compactMap({ $0 as? UIWindowScene })
        .first?.windows
        .first(where: { $0.isKeyWindow })?.rootViewController
    }
    
    guard let rootViewController = rootViewController else {
      result(FlutterError(
        code: "NO_VIEW_CONTROLLER",
        message: "No root view controller available",
        details: nil
      ))
      return
    }
    
    do {
      let chatView = HubspotChatView(manager: HubspotManager.shared)
      let hostingController = UIHostingController(rootView: chatView)
      
      // Create a navigation controller
      let navigationController = UINavigationController(rootViewController: hostingController)
      
      // Add close button
      let closeButton = UIBarButtonItem(
        title: "Close",
        style: .plain,
        target: self,
        action: #selector(closeChat)
      )
      hostingController.navigationItem.leftBarButtonItem = closeButton
      
      // Set presentation style to sheet
      if #available(iOS 15.0, *) {
        if let sheet = navigationController.sheetPresentationController {
          sheet.detents = [.large()]
          sheet.prefersGrabberVisible = true
        }
      }
      
      // Present the navigation controller
      rootViewController.present(navigationController, animated: true) {
        self.log("Chat view presented successfully")
      }
      result(nil)
    } catch {
      log("Failed to present chat view: \(error.localizedDescription)")
      result(FlutterError(
        code: "CHAT_ERROR",
        message: "Failed to open chat: \(error.localizedDescription)",
        details: nil
      ))
    }
  }
  
  @objc private func closeChat() {
    rootViewController?.dismiss(animated: true) {
      self.log("Chat view dismissed")
    }
  }
}
