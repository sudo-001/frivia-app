import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:html_unescape/html_unescape.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 10;
  List? questions;
  int _currentQuestionCount = 0;
  final unescape = HtmlUnescape();
  int score = 0;

  final String currentDifficultyLevel;

  BuildContext context;
  GamePageProvider(
      {required this.context, required this.currentDifficultyLevel}) {
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    // print("label here is : ${currentDifficultyLevel}");
    var diff = getCurrentDifficulty();
    var _response = await _dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': currentDifficultyLevel,
      },
    );

    var _data = jsonDecode(
      _response.toString(),
    );
    if (_data["results"] is List<dynamic>) {
      questions = _data["results"];
      // print("datas : ${questions![_currentQuestionCount]}");
      notifyListeners();
    }
  }

  String getCurrentQuestionText() {
    return unescape.convert(questions![_currentQuestionCount]['question']);
  }

  int getCurrentQuestionCount() {
    return _currentQuestionCount;
  }

  String getCurrentDifficulty() {
    return currentDifficultyLevel;
  }

  // void setCurrentDifficulty(double _level) {
  //   if (_level == 0.0) {
  //     currentDifficultyLevel = "Easy";
  //   } else if (_level == 0.5) {
  //     currentDifficultyLevel = "Medium";
  //   } else if (_level == 1.0) {
  //     currentDifficultyLevel = "Hard";
  //   }

  //   notifyListeners();
  // }

  void answerQuestion(String _answer) async {
    bool isCorrect =
        questions![_currentQuestionCount]["correct_answer"] == _answer;
    _currentQuestionCount++;
    score = isCorrect ? score + 1 : score;
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            icon: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              size: 25,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );

    Navigator.pop(context);
    // print(isCorrect ? "correct" : "not correct");
    // print("datas : ${questions![_currentQuestionCount]}");
    if (_currentQuestionCount == _maxQuestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            "End Game!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          content: Text(
            "Score : $score/$_maxQuestions",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      },
    );

    await Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
    Navigator.pop(context);
    Navigator.pop(context);
    // _currentQuestionCount = 0;
  }
}
