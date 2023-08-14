import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
// Replace "YOUR_API_KEY_HERE" with your valid Google Maps API key
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
