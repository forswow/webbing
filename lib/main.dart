import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:webbing/data/pref.dart';
import 'package:webbing/quiz/question.dart';
import 'package:webbing/quiz/quiz_screen.dart';
import 'package:webbing/quiz/quizgame.dart';
import 'package:webbing/river/river.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Pref.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = <Question>[for (var q in sportQuiz) Question.fromMap(q)];
    return Scaffold(
      body: SafeArea(child: Consumer(
        builder: (context, ref, child) {
          ref.watch(River.internetConnectionCheckerProvider.selectAsync((data) {
            if (data == InternetConnectionStatus.disconnected) {
              Future.delayed(
                  const Duration(milliseconds: 300),
                  () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'The application requires access to the network',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    if (data ==
                                        InternetConnectionStatus.disconnected) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const HomePage(),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('Ok'))
                            ],
                          );
                        },
                      ));
            }
          }));
          return ref.watch(River.remotePod).when(
                data: (url) {
                  return url == '' 
                      ? QuizScreen(
                          game: QuizGame(
                            questions: quiz,
                          ),
                        )
                      : WebPage(url: url);
                },
                error: (error, stackTrace) => Center(
                  child: Text(
                    error.toString(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              );
        },
      )),
    );
  }
}

class WebPage extends StatefulWidget {
  const WebPage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late InAppWebViewController? webviewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webviewController!.canGoBack()) {
          webviewController!.goBack();
          return false;
        } else {
          return false;
        }
      },
      child: Scaffold(
        body: InAppWebView(
          onWebViewCreated: (c) => webviewController = c,
          initialUrlRequest: URLRequest(url: Uri.tryParse(widget.url)),
          initialOptions:
              InAppWebViewGroupOptions(android: AndroidInAppWebViewOptions()),
        ),
      ),
    );
  }
}
