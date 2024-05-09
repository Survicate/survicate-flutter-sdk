import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:survicate_sdk/survicate_sdk_event_listener.dart';

import 'survicate_sdk_platform_channels.dart';

abstract class SurvicateSdkPlatform extends PlatformInterface {
  /// Constructs a SurvicateSdkPlatform.
  SurvicateSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static SurvicateSdkPlatform _instance = SurvicateSdkChannels();

  /// The default instance of [SurvicateSdkPlatform] to use.
  ///
  /// Defaults to [SurvicateSdkChannels].
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

  Future<void> invokeEvent(String eventName, Map<String, String> properties) {
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

  void addSurvicateEventListener(SurvicateEventListenerInterface listener) {
    throw UnimplementedError('addListener() has not been implemented.');
  }

  void removeSurvicateEventListener(SurvicateEventListenerInterface listener) {
    throw UnimplementedError('removeListener() has not been implemented.');
  }
}
