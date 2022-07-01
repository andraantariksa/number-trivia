import 'dart:convert';

import 'package:number_trivia/features/number_trivia/data/database/database.dart';
import 'package:number_trivia/features/number_trivia/domain/entity/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel(int number, String description)
      : super(number, description);

  factory NumberTriviaModel.fromJson(String input) {
    Map<String, dynamic> data = jsonDecode(input);
    return NumberTriviaModel((data['number'] as num).toInt(), data['text']);
  }

  factory NumberTriviaModel.fromNumberTriviaData(NumberTriviaData data) {
    return NumberTriviaModel(data.number, data.description);
  }

  NumberTriviaData toNumberTriviaData() {
    return NumberTriviaData(number: number, description: description);
  }
}
