import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'survicate_sdk_platform_interface.dart';

/// An implementation of [SurvicateSdkPlatform] that uses method channels.
class MethodChannelSurvicateSdk extends SurvicateSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('survicate_sdk');

  @override
  Future<void> initializeSdk() async {
    await methodChannel.invokeMethod('initializeSdk');
  }

  @override
  Future<void> setWorkspaceKey(String workspaceKey) async {
    await methodChannel.invokeMethod('setWorkspaceKey', workspaceKey);
  }

  @override
  Future<void> invokeEvent(String eventName) async {
    await methodChannel.invokeMethod('invokeEvent', eventName);
  }

  @override
  Future<void> enterScreen(String screenName) async {
    await methodChannel.invokeMethod('enterScreen', screenName);
  }

  @override
  Future<void> leaveScreen(String screenName) async {
    await methodChannel.invokeMethod('leaveScreen', screenName);
  }

  @override
  Future<void> setUserId(String userId) async {
    await methodChannel.invokeMethod('setUserId', userId);
  }

  @override
  Future<void> setUserTrait(String key, String value) async {
    await methodChannel.invokeMethod('setUserTrait', [key, value]);
  }

  @override
  Future<void> reset() async {
    await methodChannel.invokeMethod('reset');
  }
}
