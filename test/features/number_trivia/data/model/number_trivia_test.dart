import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/model/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entity/number_trivia.dart';

import '../../../../fixtures/fixtures.dart';

void main() {
  const numberTriviaModel = NumberTriviaModel(418,
      "418 is the error code for \"I'm a teapot\" in the Hyper Text Coffee Pot Control Protocol.");

  test(
    'should be a subclass of NumberTrivia (an entity)',
    () async {
      // assert
      expect(numberTriviaModel, isA<NumberTrivia>());
    },
  );

  group('fromJson', () {
    test('should return a NumberTrivia by decoding a string', () async {
      final result = NumberTriviaModel.fromJson(fixtureString("trivia.json"));
      expect(result, equals(numberTriviaModel));
    });
  });
}
