import 'package:flutter/material.dart';

import 'quizgame.dart';

class QuizScreen extends StatefulWidget {
  final QuizGame game;

  const QuizScreen({super.key, required this.game});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sports Quiz')),
        body: !widget.game.isFinished()
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      widget.game.getCurrentQuestion().questionText,
                       style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ...widget.game.getCurrentQuestion().answers.map(
                        (answer) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              widget.game.answerQuestion(answer);
                              setState(() {});
                            },
                            child: Text(answer.answerText),
                          ),
                        ),
                      ),
                ],
              )
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your Score\n${widget.game.score.toString()}',
                      style: const TextStyle(
                          fontSize: 42, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          widget.game.restartQuiz();
                          setState(() {});
                        },
                        child: const Text('Restart'))
                  ],
                ),
              ));
  }
}
