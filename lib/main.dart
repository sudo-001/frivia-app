import 'package:flutter/material.dart';
import 'package:friviaapp/pages/game_page.dart';
import 'package:friviaapp/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frivia',
      theme: ThemeData(
        fontFamily: 'ArchitectsDaughter',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1.0),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      // routes: {
      //   "/home": (context) => HomePage(),
      //   "/game": (context) => GamePage(),
      // },
      // initialRoute: "/home",
    );
  }
}
