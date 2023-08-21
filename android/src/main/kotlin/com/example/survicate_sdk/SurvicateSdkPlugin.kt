package com.example.survicate_sdk

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
      SET_USER_ID -> setUserId(call.arguments!! as String)
      SET_USER_TRAIT -> setUserTrait(call.argument("key")!!, call.argument("value")!!)
      RESET -> Survicate.reset()
      else -> throw NotImplementedError("Method ${call.method} is not implemented")
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun setUserId(id: String) {
    val userTrait = UserTrait.UserId(id)
    Survicate.setUserTrait(userTrait)
  }

  private fun setUserTrait(key: String, value: String) {
    val userTrait = UserTrait(key, value)
    Survicate.setUserTrait(userTrait)
  }

  private companion object {
    const val SET_WORKSPACE_KEY = "setWorkspaceKey"
    const val INITIALIZE_SDK = "initializeSdk"
    const val INVOKE_EVENT = "invokeEvent"
    const val ENTER_SCREEN = "enterScreen"
    const val LEAVE_SCREEN = "leaveScreen"
    const val SET_USER_ID = "setUserId"
    const val SET_USER_TRAIT = "setUserTrait"
    const val RESET = "reset"
  }
}
