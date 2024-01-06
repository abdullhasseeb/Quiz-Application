class QuestionsModel {
  int? id;
  String question;
  List<String> options;
  int correct_option;
  String quiz_type;

  QuestionsModel({
    this.id,
    required this.question,
    required this.options,
    required this.correct_option,
    required this.quiz_type
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': options.join(','),
      'correct_option': correct_option,
      'quiz_type' : quiz_type,
    };
  }

  factory QuestionsModel.fromMap(Map<String, dynamic> map) {
    List<String> options = map['options'].split(',');
    return QuestionsModel(
      id: map['id'],
      question: map['question'],
      options: options,
      correct_option: map['correct_option'],
      quiz_type: map['quiz_type']
    );
  }
}
