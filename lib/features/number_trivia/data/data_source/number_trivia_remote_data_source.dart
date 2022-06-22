import 'package:number_trivia/features/number_trivia/data/model/number_trivia.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl extends NumberTriviaRemoteDataSource {
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    throw UnimplementedError();
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
