import Flutter
import UIKit
import Survicate

public class SurvicateSdkPlugin: NSObject, FlutterPlugin {
 
    let setWorkspaceKey = "setWorkspaceKey"
    let initializeSdk = "initializeSdk"
    let invokeEvent = "invokeEvent"
    let enterScreen = "enterScreen"
    let leaveScreen = "leaveScreen"
    let setUserId = "setUserId"
    let userId = "user_id"
    let setUserTrait = "setUserTrait"
    let reset = "reset"
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "survicate_sdk", binaryMessenger: registrar.messenger())
        let instance = SurvicateSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case setWorkspaceKey:
            let workspaceKey = call.arguments as! String
            try? SurvicateSdk.shared.setWorkspaceKey(workspaceKey)
            result(nil)
        case initializeSdk:
            SurvicateSdk.shared.initialize()
            result(nil)
        case invokeEvent:
            let name = call.arguments as! String
            SurvicateSdk.shared.invokeEvent(name: name)
            result(nil)
        case enterScreen:
            let name = call.arguments as! String
            SurvicateSdk.shared.enterScreen(value: name)
            result(nil)
        case leaveScreen:
            let name = call.arguments as! String
            SurvicateSdk.shared.leaveScreen(value: name)
            result(nil)
        case setUserId:
            let value = call.arguments as! String
            SurvicateSdk.shared.setUserTrait(withName: userId, value: value)
            result(nil)
        case setUserTrait:
            let values = call.arguments as! Array<String>
            let userTrait = UserTrait(withName: values[0], value: values[1])
            SurvicateSdk.shared.setUserTrait(userTrait)
            result(nil)
        case reset:
            SurvicateSdk.shared.reset()
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
