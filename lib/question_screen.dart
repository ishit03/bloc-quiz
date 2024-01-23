import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/quiz_bloc.dart';
import 'models/question_model.dart';
import 'score_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late List<QuestionModel> questionList;
  int questionIndex = 0;
  int selectedIndex = -1;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    questionList = context.read<QuizCubit>().questions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Quiz'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Text(
              questionList[questionIndex].question,
              maxLines: 2,
              style: const TextStyle(fontSize: 23.0),
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, optionIndex) {
                    return InkWell(
                      onTap: () {
                        if (selectedIndex == -1) {
                          setState(() {
                            isCorrect = context
                                .read<QuizCubit>()
                                .checkAnswer(questionIndex, optionIndex);
                            selectedIndex = optionIndex;
                          });
                        }
                      },
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 50.0),
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        alignment: Alignment.centerLeft,
                        color: (selectedIndex == optionIndex)
                            ? (isCorrect)
                                ? Colors.greenAccent
                                : Colors.redAccent
                            : const Color(0xfff1f1f1),
                        child: Text(
                          questionList[questionIndex].options[optionIndex],
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (selectedIndex == -1) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Select an option!!'),
              duration: Duration(seconds: 1),
            ));
          } else if (questionIndex + 1 < questionList.length) {
            selectedIndex = -1;
            isCorrect = false;
            setState(() {
              questionIndex += 1;
            });
          } else {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ScoreScreen()));
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            foregroundColor: MaterialStateProperty.all(Colors.white)),
        child: const Text('Next'),
      ),
    );
  }
}
