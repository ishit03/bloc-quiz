import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/blocs/quiz_bloc.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final score = context.read<QuizCubit>().score;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Quiz'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Stack(
        children: [
          Center(
            child: Text('${getFeedback(score)} \n $score / 10',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30.0,
                    color: (score > 5) ? Colors.greenAccent : Colors.redAccent,
                    fontWeight: FontWeight.bold)),
          ),
          Positioned(
              bottom: 10,
              right: 10,
              child: ElevatedButton(
                onPressed: () {
                  exit(0);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                child: const Text('Exit'),
              )),
        ],
      ),
    );
  }

  String getFeedback(int score) {
    if (score == 10) {
      return "YAYY!! You Got Full Score";
    } else if (score > 5) {
      return "You were almost there..";
    } else {
      return "You need to practice BLoC";
    }
  }
}
