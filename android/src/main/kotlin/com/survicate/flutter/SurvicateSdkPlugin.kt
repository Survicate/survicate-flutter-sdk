package com.survicate.flutter

import android.content.Context
import androidx.annotation.NonNull
import com.survicate.surveys.Survicate
import com.survicate.surveys.traits.UserTrait

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SurvicateSdkPlugin */
class SurvicateSdkPlugin: FlutterPlugin, MethodCallHandler {

  private lateinit var channel: MethodChannel
  private lateinit var applicationContext: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "survicate_sdk")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      SET_WORKSPACE_KEY -> Survicate.setWorkspaceKey(call.arguments!! as String)
      INITIALIZE_SDK -> Survicate.init(applicationContext)
      INVOKE_EVENT -> Survicate.invokeEvent(call.arguments!! as String)
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
      else -> throw NotImplementedError("Method ${call.method} is not implemented")
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
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
  }
}
