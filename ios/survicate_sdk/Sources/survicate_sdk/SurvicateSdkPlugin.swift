import Flutter
import UIKit
import Survicate

public class SurvicateSdkPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    enum Method: String {
        case setWorkspaceKey = "setWorkspaceKey"
        case initializeSdk = "initializeSdk"
        case invokeEvent = "invokeEvent"
        case enterScreen = "enterScreen"
        case leaveScreen = "leaveScreen"
        case setUserTraits = "setUserTraits"
        case setUserTrait = "setUserTrait"
        case reset = "reset"
        case setLocale = "setLocale"
    }
    
    enum Event: String {
        case onSurveyDisplayed = "onSurveyDisplayed"
        case onQuestionAnswered = "onQuestionAnswered"
        case onSurveyClosed = "onSurveyClosed"
        case onSurveyCompleted = "onSurveyCompleted"
    }
    
    enum EventKeys: String {
        case eventType = "event_type"
        case surveyId = "surveyId"
        case surveyName = "surveyName"
        case responseUuid = "responseUuid"
        case visitorUuid = "visitorUuid"
        case questionId = "questionId"
        case question = "question"
        case answerType = "answerType"
        case answerId = "answerId"
        case answerIds = "answerIds"
        case answerValue = "answerValue"
        case panelAnswerUrl = "panelAnswerUrl"
    }
    
    private var eventChannel: FlutterEventChannel?
    private var eventSink: FlutterEventSink?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "survicate_sdk", binaryMessenger: registrar.messenger())
        let instance = SurvicateSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        let eventChannel = FlutterEventChannel(name: "survicate_sdk_events", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(instance)
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
            if let params = call.arguments as? [String: Any],
               let name = params["eventName"] as? String,
               let properties = params["eventProperties"] as? [String: String] {
                SurvicateSdk.shared.invokeEvent(name: name, with: properties)
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
        case .setLocale:
            if let locale = call.arguments as? String {
                SurvicateSdk.shared.setLocale(locale)
            }
            result(nil)
        }
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        SurvicateSdk.shared.addListener(self)
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        SurvicateSdk.shared.removeListener(self)
        return nil
    }
}

extension SurvicateSdkPlugin: SurvicateDelegate {
    public func surveyDisplayed(event: SurveyDisplayedEvent) {
        let params: [String: Any] = [
            EventKeys.eventType.rawValue: Event.onSurveyDisplayed.rawValue,
            EventKeys.surveyId.rawValue: event.surveyId
        ]
        self.eventSink?(params)
    }
    
    public func questionAnswered(_ event: QuestionAnsweredEvent) {
        let params: [String: Any] = [
            EventKeys.eventType.rawValue: Event.onQuestionAnswered.rawValue,
            EventKeys.surveyId.rawValue: event.surveyId,
            EventKeys.surveyName.rawValue: event.surveyName,
            EventKeys.responseUuid.rawValue: event.responseUUID,
            EventKeys.visitorUuid.rawValue: event.visitorUUID,
            EventKeys.panelAnswerUrl.rawValue: event.panelAnswerUrl,
            EventKeys.questionId.rawValue: event.questionID,
            EventKeys.question.rawValue: event.question,
            EventKeys.answerType.rawValue: event.answer.type,
            EventKeys.answerId.rawValue: event.answer.id,
            EventKeys.answerIds.rawValue: event.answer.ids ?? [],
            EventKeys.answerValue.rawValue: event.answer.value
        ]
        self.eventSink?(params)
    }
    
    public func surveyClosed(event: SurveyClosedEvent) {
        let params: [String: Any] = [
            EventKeys.eventType.rawValue: Event.onSurveyClosed.rawValue,
            EventKeys.surveyId.rawValue: event.surveyId
        ]
        self.eventSink?(params)
    }
    
    public func surveyCompleted(event: SurveyCompletedEvent) {
        let params: [String: Any] = [
            EventKeys.eventType.rawValue: Event.onSurveyCompleted.rawValue,
            EventKeys.surveyId.rawValue: event.surveyId
        ]
        self.eventSink?(params)
    }
}
