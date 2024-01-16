abstract class QuizEvent {}

class StartQuizEvent extends QuizEvent {}

class FetchNextQuestionEvent extends QuizEvent {}

class AnswerSubmittedEvent extends QuizEvent {
  final bool isCorrect;

  AnswerSubmittedEvent({required this.isCorrect});
}
