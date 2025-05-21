package com.survicate.flutter

import android.content.Context
import androidx.annotation.NonNull
import com.survicate.surveys.QuestionAnsweredEvent
import com.survicate.surveys.SurveyClosedEvent
import com.survicate.surveys.SurveyCompletedEvent
import com.survicate.surveys.SurveyDisplayedEvent
import com.survicate.surveys.Survicate
import com.survicate.surveys.SurvicateEventListener
import com.survicate.surveys.traits.UserTrait
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler

/** SurvicateSdkPlugin */
class SurvicateSdkPlugin : FlutterPlugin, MethodCallHandler, StreamHandler {

    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private lateinit var applicationContext: Context
    private var events: EventChannel.EventSink? = null
    private val eventListener = object : SurvicateEventListener() {
        override fun onSurveyDisplayed(event: SurveyDisplayedEvent) {
            val params = hashMapOf(
                EVENT_TYPE to ON_SURVEY_DISPLAYED,
                SURVEY_ID to event.surveyId
            )
            events?.success(params)
        }

        override fun onQuestionAnswered(event: QuestionAnsweredEvent) {
            val params = hashMapOf(
                EVENT_TYPE to ON_QUESTION_ANSWERED,
                SURVEY_ID to event.surveyId,
                SURVEY_NAME to event.surveyName,
                RESPONSE_UUID to event.responseUuid,
                VISITOR_UUID to event.visitorUuid,
                PANEL_ANSWER_URL to event.panelAnswerUrl,
                QUESTION_ID to event.questionId,
                QUESTION to event.questionText,
                ANSWER_TYPE to event.answer.type,
                ANSWER_ID to event.answer.id,
                ANSWER_IDS to (event.answer.ids?.toList() ?: emptyList()),
                ANSWER_VALUE to event.answer.value
            )
            events?.success(params)
        }

        override fun onSurveyClosed(event: SurveyClosedEvent) {
            val params = hashMapOf(
                EVENT_TYPE to ON_SURVEY_CLOSED,
                SURVEY_ID to event.surveyId
            )
            events?.success(params)
        }

        override fun onSurveyCompleted(event: SurveyCompletedEvent) {
            val params = hashMapOf(
                EVENT_TYPE to ON_SURVEY_COMPLETED,
                SURVEY_ID to event.surveyId
            )
            events?.success(params)
        }
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "survicate_sdk")
        methodChannel.setMethodCallHandler(this)
        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "survicate_sdk_events")
        eventChannel.setStreamHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            SET_WORKSPACE_KEY -> Survicate.setWorkspaceKey(call.arguments!! as String)
            INITIALIZE_SDK -> Survicate.init(applicationContext)
            INVOKE_EVENT -> {
                val eventName = call.argument<String>("eventName")
                val eventProperties = call.argument<Map<String, String>>("eventProperties")
                if (eventName != null && eventProperties != null) {
                    Survicate.invokeEvent(eventName, eventProperties)
                }
            }
            ENTER_SCREEN -> Survicate.enterScreen(call.arguments!! as String)
            LEAVE_SCREEN -> Survicate.leaveScreen(call.arguments!! as String)
            SET_USER_TRAIT -> {
                val values = call.arguments as List<String>
                if (values.size >= 2) {
                    setUserTrait(values[0], values[1])
                } else {
                    throw IllegalArgumentException("Arguments must be a list of at least two strings")
                }
            }
            SET_USER_TRAITS -> setUserTraits(call.arguments!! as Map<String, String>)
            RESET -> Survicate.reset()
            SET_LOCALE -> {
                Survicate.setLocale(call.arguments!! as String)
            }
            else -> throw NotImplementedError("Method ${call.method} is not implemented")
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        this.events = events
        Survicate.addEventListener(eventListener)
    }

    override fun onCancel(arguments: Any?) {
        this.events = null
        Survicate.removeEventListener(eventListener)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    private fun setUserTrait(key: String, value: String) {
        val userTrait = UserTrait(key, value)
        Survicate.setUserTrait(userTrait)
    }

    private fun setUserTraits(values: Map<String, String>) {
        val userTraits = values.map { UserTrait(it.key, it.value) }

        Survicate.setUserTraits(userTraits)
    }

    private companion object {
        const val SET_WORKSPACE_KEY = "setWorkspaceKey"
        const val INITIALIZE_SDK = "initializeSdk"
        const val INVOKE_EVENT = "invokeEvent"
        const val ENTER_SCREEN = "enterScreen"
        const val LEAVE_SCREEN = "leaveScreen"
        const val SET_USER_TRAIT = "setUserTrait"
        const val SET_USER_TRAITS = "setUserTraits"
        const val RESET = "reset"
        const val SET_LOCALE = "setLocale"

        const val ON_SURVEY_DISPLAYED = "onSurveyDisplayed"
        const val ON_QUESTION_ANSWERED = "onQuestionAnswered"
        const val ON_SURVEY_CLOSED = "onSurveyClosed"
        const val ON_SURVEY_COMPLETED = "onSurveyCompleted"

        const val EVENT_TYPE = "event_type"
        const val SURVEY_ID = "surveyId"
        const val SURVEY_NAME = "surveyName"
        const val RESPONSE_UUID = "responseUuid"
        const val VISITOR_UUID = "visitorUuid"
        const val QUESTION_ID = "questionId"
        const val QUESTION = "question"
        const val ANSWER_TYPE = "answerType"
        const val ANSWER_ID = "answerId"
        const val ANSWER_IDS = "answerIds"
        const val ANSWER_VALUE = "answerValue"
        const val PANEL_ANSWER_URL = "panelAnswerUrl"
    }
}
