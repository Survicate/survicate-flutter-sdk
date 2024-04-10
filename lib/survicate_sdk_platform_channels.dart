import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:survicate_sdk/survicate_sdk_event_listener.dart';
import 'package:survicate_sdk/survicate_sdk_event_models.dart';

import 'survicate_sdk_platform_interface.dart';

/// An implementation of [SurvicateSdkPlatform] that uses method/event channels.
class SurvicateSdkChannels extends SurvicateSdkPlatform {
  /// Channels used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('survicate_sdk');
  @visibleForTesting
  final eventChannel = const EventChannel('survicate_sdk_events');

  final List<SurvicateEventListenerInterface> _eventListeners = [];
  StreamSubscription? _eventSubscription;

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
  Future<void> setUserTrait(String key, String value) async {
    await methodChannel.invokeMethod('setUserTrait', [key, value]);
  }

  @override
  Future<void> setUserTraits(Map<String, String> traits) async {
    await methodChannel.invokeMethod('setUserTraits', traits);
  }

  @override
  Future<void> reset() async {
    await methodChannel.invokeMethod('reset');
  }

  @override
  void addSurvicateEventListener(SurvicateEventListenerInterface listener) {
    _eventListeners.add(listener);
    if (_eventListeners.length > 1) return;
    _eventSubscription = eventChannel
        .receiveBroadcastStream()
        .map<Map<String, dynamic>>(
          (dynamic event) => Map<String, dynamic>.from(event as Map),
        )
        .listen((map) {
      for (var eventListener in _eventListeners) {
        switch (map['event_type'] as String) {
          case 'onSurveyDisplayed':
            eventListener.onSurveyDisplayed(SurveyDisplayedEvent.from(map));
            break;
          case 'onQuestionAnswered':
            eventListener.onQuestionAnswered(QuestionAnsweredEvent.from(map));
            break;
          case 'onSurveyClosed':
            eventListener.onSurveyClosed(SurveyClosedEvent.from(map));
            break;
          case 'onSurveyCompleted':
            eventListener.onSurveyCompleted(SurveyCompletedEvent.from(map));
            break;
        }
      }
    });
  }

  @override
  void removeSurvicateEventListener(SurvicateEventListenerInterface listener) {
    _eventListeners.remove(listener);
    if (_eventListeners.isNotEmpty) return;
    _eventSubscription?.cancel();
  }
}
