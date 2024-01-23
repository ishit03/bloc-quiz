class QuestionModel {
  final String question;
  final List<String> options;
  final int answer;

  QuestionModel(
      {required this.question, required this.options, required this.answer});

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        question: json['questionText'],
        options: List<String>.from(json['options']),
        answer: json['correctAnswer'],
      );
}
