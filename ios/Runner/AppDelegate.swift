import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller = window?.rootViewController as! FlutterViewController
        let secureChannel = FlutterMethodChannel(name: "com.yourcompany.app/secure", binaryMessenger: controller.binaryMessenger)
        secureChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if (call.method == "enableSecureFlag") {
                if #available(iOS 13.0, *) {
                    UIApplication.shared.windows.first?.layer.contents = nil
                    let privacyView = UIView(frame: UIScreen.main.bounds)
                    privacyView.backgroundColor = .white
                    privacyView.tag = 1234
                    UIApplication.shared.windows.first?.addSubview(privacyView)
                }
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
