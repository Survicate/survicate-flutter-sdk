// ignore_for_file: unused_element

import 'package:survicate_sdk/survicate_sdk_event_models.dart';

abstract class SurvicateEventListenerInterface {
  void onSurveyDisplayed(SurveyDisplayedEvent event) {}
  void onQuestionAnswered(QuestionAnsweredEvent event) {}
  void onSurveyClosed(SurveyClosedEvent event) {}
  void onSurveyCompleted(SurveyCompletedEvent event) {}
}

class SurvicateEventListener implements SurvicateEventListenerInterface {
  final void Function(SurveyDisplayedEvent event)? surveyDisplayed;
  final void Function(QuestionAnsweredEvent event)? questionAnswered;
  final void Function(SurveyClosedEvent event)? surveyClosed;
  final void Function(SurveyCompletedEvent event)? surveyCompleted;

  SurvicateEventListener({
    this.surveyDisplayed,
    this.questionAnswered,
    this.surveyClosed,
    this.surveyCompleted,
  });

  @override
  void onSurveyDisplayed(SurveyDisplayedEvent event) {
    if (surveyDisplayed != null) {
      surveyDisplayed!(event);
    }
  }

  @override
  void onQuestionAnswered(QuestionAnsweredEvent event) {
    if (questionAnswered != null) {
      questionAnswered!(event);
    }
  }

  @override
  void onSurveyClosed(SurveyClosedEvent event) {
    if (surveyClosed != null) {
      surveyClosed!(event);
    }
  }

  @override
  void onSurveyCompleted(SurveyCompletedEvent event) {
    if (surveyCompleted != null) {
      surveyCompleted!(event);
    }
  }
}
