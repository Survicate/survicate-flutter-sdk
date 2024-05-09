// ignore_for_file: unused_element

import 'package:survicate_sdk/survicate_sdk_event_models.dart';

abstract class SurvicateEventListenerInterface {
  void surveyDisplayed(SurveyDisplayedEvent event) {}
  void questionAnswered(QuestionAnsweredEvent event) {}
  void surveyClosed(SurveyClosedEvent event) {}
  void surveyCompleted(SurveyCompletedEvent event) {}
}

class SurvicateEventListener implements SurvicateEventListenerInterface {
  final void Function(SurveyDisplayedEvent event)? onSurveyDisplayed;
  final void Function(QuestionAnsweredEvent event)? onQuestionAnswered;
  final void Function(SurveyClosedEvent event)? onSurveyClosed;
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
