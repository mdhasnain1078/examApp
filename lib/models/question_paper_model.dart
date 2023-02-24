import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaperModel {
  String? id;
  String? title;
  String? imageUrl;
  String? description;
  int? timeSeconds;
  List<Questions>? questions;
  int? questionCount;

  QuestionPaperModel({
    this.id,
    this.title,
    this.imageUrl,
    this.description,
    this.timeSeconds,
    required this.questionCount,
    this.questions,
  });

  QuestionPaperModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['image_url'];
    description = json['Description'];
    timeSeconds = json['time_seconds'];
    questionCount = 0;
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions?.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_url'] = imageUrl;
    data['Description'] = description;
    data['time_seconds'] = timeSeconds;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  QuestionPaperModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    title = json['title'];
    imageUrl = json['image_url'];
    description = json['description'];
    timeSeconds = json['time_second'];
    questionCount = json['question_count'] as int;
    questions = [];
  }

  String timeInMinutes() => "${(timeSeconds! / 60).ceil()} mins";
}

class Questions {
  String? id;
  String? question;
  List<Answers>? answers;
  String? correctAnswer;
  String? selectedAnswer;

  Questions({this.id, this.question, this.answers, this.correctAnswer});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers?.add(Answers.fromJson(v));
      });
    }
    correctAnswer = json['correct_answer'];
  }

  Questions.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    id = snapshot.id;
    question = snapshot['question'];
    correctAnswer = snapshot['correct_answer'];
    answers = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['question'] = question;
    if (answers != null) {
      data['answers'] = answers?.map((v) => v.toJson()).toList();
    }
    data['correct_answer'] = correctAnswer;
    return data;
  }
}

class Answers {
  String? identifier;
  String? answer;

  Answers({this.identifier, this.answer});

  Answers.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    answer = json['Answer'];
  }

  Answers.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    identifier = snapshot['identifier'];
    answer = snapshot['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['identifier'] = identifier;
    data['answer'] = answer;
    return data;
  }
}
