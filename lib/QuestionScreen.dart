import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/blocs/QuizEvent.dart';
import 'package:quiz_app/blocs/QuizState.dart';

import 'ScoreScreen.dart';
import 'blocs/QuizBloc.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Quiz'),
        backgroundColor: Colors.lightBlue,
      ),
      body: BlocConsumer<QuizBloc, QuizState>(listener: (context, state) {
        if (state is QuizEndedState) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ScoreScreen()));
        }
      }, builder: (context, state) {
        if (state is QuizLoadedState) {
          context.read<QuizBloc>().add(FetchNextQuestionEvent());
        } else if (state is QuestionLoadedState) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  state.question,
                  style: const TextStyle(
                    fontSize: 23.0,
                  ),
                  maxLines: 2,
                ),
                SizedBox.fromSize(size: const Size(0, 10.0)),
                SizedBox(
                  height: 500.0,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            showAnswer = true;
                          });
                          context.read<QuizBloc>().add(AnswerSubmittedEvent(
                              isCorrect: (index == state.correctOption)));
                        },
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 50.0),
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 5.0),
                          color: (showAnswer)
                              ? (index == state.correctOption)
                                  ? Colors.greenAccent
                                  : Colors.redAccent
                              : const Color(0xfff1f1f1),
                          child: Text(
                            state.options[index],
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (showAnswer) {
                        showAnswer = false;
                        context.read<QuizBloc>().add(FetchNextQuestionEvent());
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Select an answer!!'),
                          duration: Duration(seconds: 1),
                        ));
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: const Text('Next'),
                  ),
                )
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
