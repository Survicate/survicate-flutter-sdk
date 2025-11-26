const _surveyId = "surveyId";
const _surveyName = "surveyName";
const _responseUuid = "responseUuid";
const _visitorUuid = "visitorUuid";
const _questionId = "questionId";
const _question = "question";
const _answerType = "answerType";
const _answerId = "answerId";
const _answerIds = "answerIds";
const _answerValue = "answerValue";
const _panelAnswerUrl = "panelAnswerUrl";

/// An event that is emitted when a survey is displayed to the visitor.
class SurveyDisplayedEvent {
  final String surveyId;

  SurveyDisplayedEvent({required this.surveyId});

  static SurveyDisplayedEvent from(Map<String, dynamic> map) {
    return SurveyDisplayedEvent(surveyId: map[_surveyId] as String);
  }
}

/// An event that is emitted when a visitor answers a question in a survey.
class QuestionAnsweredEvent {
  final String surveyId;
  final String surveyName;
  final String visitorUuid;
  final String responseUuid;
  final int questionId;
  final String? question;
  final SurvicateAnswer answer;
  final String panelAnswerUrl;

  QuestionAnsweredEvent({
    required this.surveyId,
    required this.surveyName,
    required this.visitorUuid,
    required this.responseUuid,
    required this.questionId,
    required this.question,
    required this.answer,
    required this.panelAnswerUrl,
  });

  static QuestionAnsweredEvent from(Map<String, dynamic> map) {
    return QuestionAnsweredEvent(
      surveyId: map[_surveyId] as String,
      surveyName: map[_surveyName] as String,
      visitorUuid: map[_visitorUuid] as String,
      responseUuid: map[_responseUuid] as String,
      questionId: map[_questionId] as int,
      question: map[_question] as String?,
      answer: SurvicateAnswer.from(map),
      panelAnswerUrl: map[_panelAnswerUrl] as String,
    );
  }
}

class SurvicateAnswer {
  final String? type;
  final int? id;
  final List<int> ids;
  final String? value;

  SurvicateAnswer({
    required this.type,
    required this.id,
    required this.ids,
    required this.value,
  });

  static SurvicateAnswer from(Map<String, dynamic> map) {
    return SurvicateAnswer(
      type: map[_answerType] as String?,
      id: map[_answerId] as int?,
      ids: List<int>.from(map[_answerIds] as List),
      value: map[_answerValue] as String?,
    );
  }
}

/// An event that is emitted when a survey is closed by the visitor.
class SurveyClosedEvent {
  final String surveyId;

  SurveyClosedEvent({required this.surveyId});

  static SurveyClosedEvent from(Map<String, dynamic> map) {
    return SurveyClosedEvent(surveyId: map[_surveyId] as String);
  }
}

/// An event that is emitted when a survey is completed by the visitor.
class SurveyCompletedEvent {
  final String surveyId;

  SurveyCompletedEvent({required this.surveyId});

  static SurveyCompletedEvent from(Map<String, dynamic> map) {
    return SurveyCompletedEvent(surveyId: map[_surveyId] as String);
  }
}
