import UIKit
import Flutter
import GoogleMaps
//import GooglePlaces


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAxlFPidhqW4a8p5SKPPPf1gZMkn06lArY")
    //GMSPlacesClient.provideAPIKey("AIzaSyAxlFPidhqW4a8p5SKPPPf1gZMkn06lArY")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}