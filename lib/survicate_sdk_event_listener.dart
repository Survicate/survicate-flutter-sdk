// ignore_for_file: unused_element

import 'package:survicate_sdk/survicate_sdk_event_models.dart';

abstract class SurvicateEventListenerInterface {
  void surveyDisplayed(SurveyDisplayedEvent event) {}
  void questionAnswered(QuestionAnsweredEvent event) {}
  void surveyClosed(SurveyClosedEvent event) {}
  void surveyCompleted(SurveyCompletedEvent event) {}
}

/// A class that listens to events emitted by the Survicate SDK.
class SurvicateEventListener implements SurvicateEventListenerInterface {
  /// Every display of a survey is followed by this event emission.
  final void Function(SurveyDisplayedEvent event)? onSurveyDisplayed;

  /// As soon as the visitor answers a question, Survicate emits this event.
  final void Function(QuestionAnsweredEvent event)? onQuestionAnswered;

  /// If at any stage of the survey, visitor clicks the close button,
  /// Survicate will emit this event.
  final void Function(SurveyClosedEvent event)? onSurveyClosed;

  /// Once a survey has been completed, Survicate emits this event.
  ///
  /// Survey is considered to be completed, when a visitor has answered every single question
  /// that was displayed to them in the configured flow.
  final void Function(SurveyCompletedEvent event)? onSurveyCompleted;

  SurvicateEventListener({
    this.onSurveyDisplayed,
    this.onQuestionAnswered,
    this.onSurveyClosed,
    this.onSurveyCompleted,
  });

  @override
  void surveyDisplayed(SurveyDisplayedEvent event) {
    if (onSurveyDisplayed != null) {
      onSurveyDisplayed!(event);
    }
  }

  @override
  void questionAnswered(QuestionAnsweredEvent event) {
    if (onQuestionAnswered != null) {
      onQuestionAnswered!(event);
    }
  }

  @override
  void surveyClosed(SurveyClosedEvent event) {
    if (onSurveyClosed != null) {
      onSurveyClosed!(event);
    }
  }

  @override
  void surveyCompleted(SurveyCompletedEvent event) {
    if (onSurveyCompleted != null) {
      onSurveyCompleted!(event);
    }
  }
}
