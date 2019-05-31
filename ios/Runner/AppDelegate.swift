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
    GMSServices.provideAPIKey("AIzaSyDNgEgc9nIsu11doxGic-125VfL3bp1JEY")
    //GMSPlacesClient.provideAPIKey("AIzaSyDNgEgc9nIsu11doxGic-125VfL3bp1JEY")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}