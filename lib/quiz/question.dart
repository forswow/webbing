import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'answer.dart';

class Question {
  final String questionText;
  final List<Answer> answers;

  Question({
    required this.questionText,
    required this.answers,
  });

  Question copyWith({
    String? questionText,
    List<Answer>? answers,
  }) =>
      Question(
        questionText: questionText ?? this.questionText,
        answers: answers ?? this.answers,
      );

  Map<String, dynamic> toMap() => {
        'questionText': questionText,
        'answers': answers.map((x) => x.toMap()).toList(),
      };

  factory Question.fromMap(Map<String, dynamic> map) => Question(
        questionText: map['questionText'] ?? '',
        answers:
            List<Answer>.from(map['answers']?.map((x) => Answer.fromMap(x))),
      );

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() =>
      'Question(questionText: $questionText, answers: $answers)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Question &&
        other.questionText == questionText &&
        listEquals(other.answers, answers);
  }

  @override
  int get hashCode => questionText.hashCode ^ answers.hashCode;
}

final sportQuiz = [
  {
    'questionText': "Which swimming style is not allowed in the Olympics?",
    'answers': [
      {"answerText": 'Butterfly', "isCorrect": false},
      {"answerText": "Backstroke", "isCorrect": false},
      {"answerText": "Freestyle", "isCorrect": false},
      {"answerText": "Dog paddle", "isCorrect": true}
    ]
  },
  {
    'questionText': "Which of the following is not a water sport?",
    'answers': [
      {"answerText": 'Paragliding', "isCorrect": true},
      {"answerText": "Cliff diving", "isCorrect": false},
      {"answerText": "Windsurfing", "isCorrect": false},
      {"answerText": "Rowing", "isCorrect": false}
    ]
  },
  {
    'questionText':
        'Which country has the most Olympic gold medals in swimming?',
    'answers': [
      {"answerText": 'China', "isCorrect": false},
      {"answerText": "The USA", "isCorrect": true},
      {"answerText": "The UK", "isCorrect": false},
      {"answerText": "Australia", "isCorrect": false}
    ]
  },
  {
    'questionText': 'When was water polo created?',
    'answers': [
      {"answerText": '20th century', "isCorrect": false},
      {"answerText": "19th century", "isCorrect": true},
      {"answerText": "18th century", "isCorrect": false},
      {"answerText": "17th century", "isCorrect": false}
    ]
  },
  {
    'questionText':
        'How many times did Efren Reyes win the World Pool League championship?',
    'answers': [
      {"answerText": 'One', "isCorrect": false},
      {"answerText": "Two", "isCorrect": true},
      {"answerText": "Three", "isCorrect": false},
      {"answerText": "Four", "isCorrect": false}
    ]
  },
  {
    'questionText': 'What year did boxing become a legal sport?',
    'answers': [
      {"answerText": '1921', "isCorrect": false},
      {"answerText": "1901", "isCorrect": true},
      {"answerText": "1931", "isCorrect": false},
      {"answerText": "1911", "isCorrect": false}
    ]
  },
  {
    'questionText': 'Where is the largest bowling centre located?',
    'answers': [
      {"answerText": 'US', "isCorrect": false},
      {"answerText": "Japan", "isCorrect": true},
      {"answerText": "Singapore", "isCorrect": false},
      {"answerText": "Finland", "isCorrect": false}
    ]
  },
  {
    'questionText':
        'Of all the fighting sports below, which sport wasn’t practised by Bruce Lee?',
    'answers': [
      {"answerText": 'Wushu', "isCorrect": true},
      {"answerText": "Boxing", "isCorrect": false},
      {"answerText": "Jeet Kune Do", "isCorrect": false},
      {"answerText": "Fencing", "isCorrect": false}
    ]
  },
  {
    'questionText': ' Where did the term “billiard” originated from?',
    'answers': [
      {"answerText": 'Italy', "isCorrect": false},
      {"answerText": "Hungary", "isCorrect": false},
      {"answerText": "Belgium", "isCorrect": false},
      {"answerText": "France", "isCorrect": true}
    ]
  }
];
