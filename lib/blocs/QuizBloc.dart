import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/blocs/QuizEvent.dart';
import 'package:quiz_app/blocs/QuizState.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(InitialState()) {
    on<StartQuizEvent>(_handleStartQuizEvent);
    on<FetchNextQuestionEvent>(_handleFetchNextQuestionEvent);
    on<AnswerSubmittedEvent>(_handleAnswerSubmittedEvent);
  }

  int score = 0;
  int questionIndex = 0;
  late String currentQuestion;
  late List<dynamic> currentOptions;
  late int correctOption;
  late final dynamic questions;

  Future<void> loadQuizData() async {
    var data = await rootBundle.loadString('assets/Questions.json');
    questions = json.decode(data)['questions'];
  }

  void fetchNextQuestion() {
    currentQuestion = questions[questionIndex]['questionText'];
    currentOptions = questions[questionIndex]['options'];
    correctOption = questions[questionIndex]['correctAnswer'];
    questionIndex += 1;
  }

  Future<void> _handleStartQuizEvent(event, emit) async {
    emit(QuestionLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    await loadQuizData();
    emit(QuizLoadedState());
  }

  void _handleFetchNextQuestionEvent(event, emit) {
    if (questionIndex < 10) {
      fetchNextQuestion();
      emit(QuestionLoadedState(
          question: currentQuestion,
          options: currentOptions,
          correctOption: correctOption));
    } else {
      emit(QuizEndedState(score: score));
    }
  }

  void _handleAnswerSubmittedEvent(event, emit) {
    if (event.isCorrect) {
      score += 1;
    }
  }
}
