import 'package:flutter/material.dart';
import 'package:friviaapp/pages/game_page.dart';
import 'package:friviaapp/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _homePageState();
}

class _homePageState extends State<HomePage> {
  double _currentFirstSliderValue = 0.0;

  final List<String> _diffculties = ["Easy", "Medium", "Hard"];
  double _currentDifficultyLevel = 0;

  GamePageProvider? _gamePageProvider;

  double? _deviceWidth, _deviceHeight;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: _deviceWidth,
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth! * 0.05,
          ),
          child: ChangeNotifierProvider(
            create: (_context) => GamePageProvider(
                context: context,
                currentDifficultyLevel:
                    _diffculties[_currentDifficultyLevel.toInt()]),
            child: _buildUI(),
          ),
        ),
      ),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (_context) {
      _gamePageProvider = _context.watch<GamePageProvider>();
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              _logo(),
              SizedBox(
                height: _deviceHeight! * 0.03,
              ),
              _level(_diffculties[_currentDifficultyLevel.toInt()]),
            ],
          ),
          _slider(),
          _startButton(),
        ],
      );
    });
  }

  Widget _logo() {
    return const Text(
      "Frivia",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 50,
      ),
    );
  }

  Widget _level(String _level) {
    return Text(
      // _gamePageProvider!.getCurrentDifficulty(),
      _level,

      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 30,
      ),
    );
  }

  Widget _slider() {
    return Slider(
      min: 0,
      max: 2,
      divisions: 2,
      thumbColor: Colors.blue,
      activeColor: Colors.blue,
      inactiveColor: Colors.blue[100],
      label: "Difficulty",
      value: _currentDifficultyLevel,
      overlayColor: const MaterialStatePropertyAll(Colors.blue),
      onChanged: (_value) {
        setState(() => {
              _currentDifficultyLevel = _value,
              // _gamePageProvider!.setCurrentDifficulty(_currentFirstSliderValue),
              // print("level : ${_gamePageProvider!.getCurrentDifficulty()}"),
              // print(_currentDifficultyLevel),
            });
      },
    );
  }

  Widget _startButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext _context) {
          return GamePage(
              difficultyLevel: _diffculties[_currentDifficultyLevel.toInt()].toLowerCase());
        }));
      },
      color: Colors.blue,
      height: _deviceHeight! * 0.08,
      minWidth: _deviceWidth! * 0.80,
      child: const Text(
        "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
