import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/model/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/entity/number_trivia.dart';

import '../../../../fixtures/fixtures.dart';

void main() {
  const numberTrivia = NumberTriviaModel(number: 1, text: 'Test Text');

  test(
    'should be a subclass of NumberTrivia (an entity)',
    () async {
      // assert
      expect(numberTrivia, isA<NumberTrivia>());
    },
  );

  const numberTriviaModel = NumberTriviaModel(
      number: 418,
      text:
          "418 is the error code for \"I'm a teapot\" in the Hyper Text Coffee Pot Control Protocol.");

  group('fromJson', () {
    test('should return a NumberTrivia by decoding a string', () async {
      final result = NumberTriviaModel.fromJson(fixture("trivia.json"));
      expect(result, numberTriviaModel);
    });
  });
}
