import 'dart:convert';

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer({
    required this.answerText,
    required this.isCorrect,
  });

  Answer copyWith({
    String? answerText,
    bool? isCorrect,
  }) {
    return Answer(
      answerText: answerText ?? this.answerText,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'answerText': answerText,
      'isCorrect': isCorrect,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      answerText: map['answerText'] ?? '',
      isCorrect: map['isCorrect'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source));

  @override
  String toString() => 'Answer(answerText: $answerText, isCorrect: $isCorrect)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Answer &&
      other.answerText == answerText &&
      other.isCorrect == isCorrect;
  }

  @override
  int get hashCode => answerText.hashCode ^ isCorrect.hashCode;
}
