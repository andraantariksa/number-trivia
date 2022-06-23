import 'package:number_trivia/features/number_trivia/data/model/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel?> getConcreteNumberTrivia(int number);
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaToCache);
}

class NumberTriviaLocalDataSourceImpl extends NumberTriviaLocalDataSource {
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaToCache) {
    // TODO: implement cacheNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<NumberTriviaModel?> getConcreteNumberTrivia(int number) {
    // TODO: implement getConcreteNumberTrivia
    throw UnimplementedError();
  }

}
