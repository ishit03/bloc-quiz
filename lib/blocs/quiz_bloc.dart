import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/blocs/quiz_state.dart';
import 'package:quiz_app/models/question_model.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(InitialState());

  int score = 0;
  List<QuestionModel> questions = List<QuestionModel>.empty(growable: true);

  Future<void> loadQuizData() async {
    final data = await rootBundle.loadString('assets/Questions.json');
    final List<Map<String, dynamic>> jsonMap =
        List<Map<String, dynamic>>.from(json.decode(data)['questions']);
    for (var element in jsonMap) {
      questions.add(QuestionModel.fromJson(element));
    }
  }

  void startQuiz() => {loadQuizData()};

  bool checkAnswer(int questionIndex, int optionIndex) {
    if (questions[questionIndex].answer == optionIndex) {
      score += 1;
      return true;
    }
    return false;
  }
}
