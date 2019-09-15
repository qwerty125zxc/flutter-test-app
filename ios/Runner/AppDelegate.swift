import UIKit
import Flutter
import Firebase
import GoogleSignIn

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, GIDSignInDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
	FirebaseApp.configure()
	GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
	GIDSignIn.sharedInstance().delegate = self


    var flutter_native_splash = 1
    UIApplication.shared.isStatusBarHidden = false

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}