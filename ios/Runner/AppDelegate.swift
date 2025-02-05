import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    if let cFBundleVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
    print("CFBundleVersion from Info.plist: \(cFBundleVersion)")
    }
    if let cFBundleShortVersionString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
    print("CFBundleShortVersionString from Info.plist: \(cFBundleShortVersionString)")
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
