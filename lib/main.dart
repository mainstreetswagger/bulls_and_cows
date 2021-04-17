import 'package:bulls_and_cows/widgets/guess.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Bulls And Cows Game';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(appTitle),
        ),
        body: GuessTextField(),
      ),
    );
  }
}
