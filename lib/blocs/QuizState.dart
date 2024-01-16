abstract class QuizState {}

class InitialState extends QuizState {}

class QuizLoadedState extends QuizState {}

class QuestionLoadingState extends QuizState {}

class QuestionLoadedState extends QuizState {
  final String question;
  final List<dynamic> options;
  final int correctOption;

  QuestionLoadedState(
      {required this.question,
      required this.options,
      required this.correctOption});
}

class QuizEndedState extends QuizState {
  final int score;

  QuizEndedState({required this.score});
}
