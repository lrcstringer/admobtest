import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let keystoreChannel = KeystoreChannel()
  private var secureField: UITextField?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    if let controller = window?.rootViewController as? FlutterViewController {
      keystoreChannel.register(with: controller.binaryMessenger)

      // Screenshot prevention method channel
      let screenshotChannel = FlutterMethodChannel(
        name: "com.imalichat/screenshot",
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

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
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
}
