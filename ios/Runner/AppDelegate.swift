import Flutter
import UIKit
import PushKit
import flutter_callkit_incoming

@main
@objc class AppDelegate: FlutterAppDelegate, PKPushRegistryDelegate {
  private var secureField: UITextField?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    if let controller = window?.rootViewController as? FlutterViewController {

      // Screenshot prevention method channel
      let screenshotChannel = FlutterMethodChannel(
        name: "com.imalichat.app/screenshot",
        binaryMessenger: controller.binaryMessenger
      )
      screenshotChannel.setMethodCallHandler { [weak self] call, result in
        switch call.method {
        case "enableSecure":
          self?.enableScreenshotPrevention()
          result(nil)
        case "disableSecure":
          self?.disableScreenshotPrevention()
          result(nil)
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    }

    // Enable screenshot prevention by default
    enableScreenshotPrevention()

    // Listen for screenshot notifications
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(userDidTakeScreenshot),
      name: UIApplication.userDidTakeScreenshotNotification,
      object: nil
    )

    // Register for VoIP push notifications
    registerVoIPPush()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // MARK: - VoIP Push Registration

  private func registerVoIPPush() {
    let registry = PKPushRegistry(queue: DispatchQueue.main)
    registry.delegate = self
    registry.desiredPushTypes = [.voIP]
  }

  private func enableScreenshotPrevention() {
    guard secureField == nil else { return }
    let field = UITextField()
    field.isSecureTextEntry = true
    if let window = self.window {
      window.addSubview(field)
      field.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
      field.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
      window.layer.superlayer?.addSublayer(field.layer)
      field.layer.sublayers?.first?.addSublayer(window.layer)
    }
    secureField = field
  }

  private func disableScreenshotPrevention() {
    secureField?.removeFromSuperview()
    secureField = nil
  }

  @objc private func userDidTakeScreenshot() {
    print("[Security] Screenshot detected")
  }

  // MARK: - PKPushRegistryDelegate

  func pushRegistry(_ registry: PKPushRegistry,
                     didUpdate pushCredentials: PKPushCredentials,
                     for type: PKPushType) {
    let token = pushCredentials.token.map { String(format: "%02x", $0) }.joined()
    print("[VoIP] Push token: \(token)")
    // Pass token to Flutter via FlutterCallkitIncoming
    SwiftFlutterCallkitIncomingPlugin.sharedInstance?.setDevicePushTokenVoIP(token)
  }

  func pushRegistry(_ registry: PKPushRegistry,
                     didReceiveIncomingPushWith payload: PKPushPayload,
                     for type: PKPushType,
                     completion: @escaping () -> Void) {
    guard type == .voIP else {
      completion()
      return
    }

    let data = payload.dictionaryPayload
    let callId = data["callId"] as? String ?? UUID().uuidString
    let callerName = data["callerName"] as? String ?? "Unknown"
    let callType = data["callType"] as? String ?? "voice"
    let hasVideo = callType == "video"

    // CRITICAL: Must report CallKit call in same run loop as VoIP push
    // to avoid iOS killing the app for not reporting a call.
    let callData = flutter_callkit_incoming.Data(id: callId, nameCaller: callerName, handle: callerName, type: hasVideo ? 1 : 0)
    callData.extra = [
      "callId": callId,
      "conversationId": data["conversationId"] as? String ?? "",
      "callerId": data["callerId"] as? String ?? "",
      "callerName": callerName,
      "callerAvatarUrl": data["callerAvatarUrl"] as? String ?? "",
      "callType": callType,
    ]

    SwiftFlutterCallkitIncomingPlugin.sharedInstance?.showCallkitIncoming(callData, fromPushKit: true)
    completion()
  }

  func pushRegistry(_ registry: PKPushRegistry,
                     didInvalidatePushTokenFor type: PKPushType) {
    print("[VoIP] Push token invalidated")
  }
}
