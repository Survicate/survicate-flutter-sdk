import Flutter
import UIKit
import Survicate

public class SurvicateSdkPlugin: NSObject, FlutterPlugin {
    enum Method: String {
        case setWorkspaceKey = "setWorkspaceKey"
        case initializeSdk = "initializeSdk"
        case invokeEvent = "invokeEvent"
        case enterScreen = "enterScreen"
        case leaveScreen = "leaveScreen"
        case setUserTraits = "setUserTraits"
        case setUserTrait = "setUserTrait"
        case reset = "reset"
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "survicate_sdk", binaryMessenger: registrar.messenger())
        let instance = SurvicateSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let method = Method(rawValue: call.method) else {
            result(FlutterMethodNotImplemented)
            return
        }

        switch method {
        case .setWorkspaceKey:
            if let workspaceKey = call.arguments as? String {
                try? SurvicateSdk.shared.setWorkspaceKey(workspaceKey)
            }
            result(nil)
        case .initializeSdk:
            SurvicateSdk.shared.initialize()
            result(nil)
        case .invokeEvent:
            if let name = call.arguments as? String {
                SurvicateSdk.shared.invokeEvent(name: name)
            }
            result(nil)
        case .enterScreen:
            if let name = call.arguments as? String {
                SurvicateSdk.shared.enterScreen(value: name)
            }
            result(nil)
        case .leaveScreen:
            if let name = call.arguments as? String {
                SurvicateSdk.shared.leaveScreen(value: name)
            }
            result(nil)
        case .setUserTrait:
            if let values = call.arguments as? Array<String>, values.count >= 2 {
                let userTrait = UserTrait(withName: values[0], value: values[1])
                SurvicateSdk.shared.setUserTrait(userTrait)
            }
            result(nil)
        case .setUserTraits:
            if let value = call.arguments as? [String: String] {
                SurvicateSdk.shared.setUserTraits(withNamesAndValues: value)
            }
            result(nil)
        case .reset:
            SurvicateSdk.shared.reset()
            result(nil)
        }
    }
}
