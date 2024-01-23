import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/blocs/quiz_bloc.dart';

import 'question_screen.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => QuizCubit(),
    child: const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Quiz'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Stack(
        children: [
          Center(
              child: ElevatedButton(
            onPressed: () {
              context.read<QuizCubit>().startQuiz();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const QuestionScreen()));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
            ),
            child: const Text(
              'Start Quiz',
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
          ))
        ],
      ),
    );
  }
}
