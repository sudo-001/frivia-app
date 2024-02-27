import 'package:flutter/material.dart';
import 'package:friviaapp/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  double? _deviceWidth, _deviceHeight;
  GamePageProvider? _gamePageProvider;

  final String difficultyLevel;

  GamePage({required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_context) => GamePageProvider(context: context, currentDifficultyLevel: difficultyLevel),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (_context) {
      _gamePageProvider = _context.watch<GamePageProvider>();
      if (_gamePageProvider!.questions != null) {
        return Scaffold(
          body: SafeArea(
              child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: _deviceHeight! * 0.05,
            ),
            child: _gameUI(),
          )),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    });
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            _questionNumber(),
            SizedBox(
              height: _deviceHeight! * 0.03,
            ),
            _questionText(),
          ],
        ),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: _deviceHeight! * 0.03,
            ),
            _falseButton(),
          ],
        ),
      ],
    );
  }

  Widget _questionNumber() {
    return Text(
      "Question ${_gamePageProvider!.getCurrentQuestionCount() + 1} / 10",
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 23,
        letterSpacing: 2.0,
      ),
    );
  }

  Widget _questionText() {
    return Text(
      _gamePageProvider!.getCurrentQuestionText(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () => {
        _gamePageProvider?.answerQuestion("True"),
      },
      color: Colors.green,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.08,
      child: const Text(
        "True",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () => {
        _gamePageProvider?.answerQuestion("False"),
      },
      color: Colors.red,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.08,
      child: const Text(
        "False",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
