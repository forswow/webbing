import 'answer.dart';
import 'question.dart';

class QuizGame {
  final List<Question> questions;
  int currentQuestionIndex = 0;
  int score = 0;

  QuizGame({required this.questions});

  bool isFinished() => currentQuestionIndex >= questions.length;

  Question getCurrentQuestion() => questions[currentQuestionIndex];

  void answerQuestion(Answer answer) {
    if (answer.isCorrect) {
      score++;
    }
    currentQuestionIndex++;
  }

  void restartQuiz() {
    score = 0;
    currentQuestionIndex = 0;
  }
}
