import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'survicate_sdk_method_channel.dart';

abstract class SurvicateSdkPlatform extends PlatformInterface {
  /// Constructs a SurvicateSdkPlatform.
  SurvicateSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static SurvicateSdkPlatform _instance = MethodChannelSurvicateSdk();

  /// The default instance of [SurvicateSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelSurvicateSdk].
  static SurvicateSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SurvicateSdkPlatform] when
  /// they register themselves.
  static set instance(SurvicateSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> setWorkspaceKey(String workspaceKey) {
    throw UnimplementedError('setWorkspaceKey() has not been implemented.');
  }

  Future<void> initializeSdk() {
    throw UnimplementedError('initializeSdk() has not been implemented.');
  }

  Future<void> invokeEvent(String eventName) {
    throw UnimplementedError('invokeEvent() has not been implemented.');
  }

  Future<void> enterScreen(String screenName) {
    throw UnimplementedError('enterScreen() has not been implemented.');
  }

  Future<void> leaveScreen(String screenName) {
    throw UnimplementedError('leaveScreen() has not been implemented.');
  }

  Future<void> setUserTrait(String key, String value) {
    throw UnimplementedError('setUserTrait() has not been implemented.');
  }

  Future<void> setUserTraits(Map<String, String> traits) {
    throw UnimplementedError('setUserTraits() has not been implemented.');
  }

  Future<void> reset() {
    throw UnimplementedError('reset() has not been implemented.');
  }
}
