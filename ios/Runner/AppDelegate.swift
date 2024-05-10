import UIKit
import Flutter
import CoreMotion
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var pedometer: CMPedometer?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBOjXv-WWTgAGmV_zIIGpKlBg2G8oLv4ko")
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let stepCounterChannel = FlutterMethodChannel(name: "step_counter_channel", binaryMessenger: controller.binaryMessenger)
        
        stepCounterChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "startListening":
                self?.startListening(result: result)
            case "stopListening":
                self?.stopListening()
                result(nil)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func startListening(result: @escaping FlutterResult) {
        if CMPedometer.isStepCountingAvailable() {
            pedometer = CMPedometer()
            pedometer?.startUpdates(from: Date()) { (pedometerData, error) in
                if let error = error {
                    print("Error starting pedometer updates: \(error)")
                    result(0)
                } else if let pedometerData = pedometerData, let numberOfSteps = pedometerData.numberOfSteps as? Int {
                    result(numberOfSteps)
                }
            }
        } else {
            print("Step counting is not available")
            result(0)
        }
    }
    
    func stopListening() {
        pedometer?.stopUpdates()
        pedometer = nil
    }
}
