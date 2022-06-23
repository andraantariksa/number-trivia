import 'dart:convert';
import 'package:number_trivia/features/number_trivia/domain/entity/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({required int number, required String text})
      : super(number: number, text: text);

  factory NumberTriviaModel.fromJson(String input) {
    Map<String, dynamic> data = jsonDecode(input);
    return NumberTriviaModel(number: data['number'], text: data['text']);
  }
}
