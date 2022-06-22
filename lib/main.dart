import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/home_page.dart';

void main() {
  runApp(const NumberTriviaApp());
}

class NumberTriviaApp extends StatelessWidget {
  const NumberTriviaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
