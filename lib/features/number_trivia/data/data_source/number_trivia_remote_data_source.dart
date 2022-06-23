import 'package:number_trivia/features/number_trivia/data/model/number_trivia.dart';
import 'package:http/http.dart' as http;
import 'package:number_trivia/features/number_trivia/data/service/numbersapi.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl extends NumberTriviaRemoteDataSource {
  final NumbersAPIService numbersAPIService;

  NumberTriviaRemoteDataSourceImpl(this.numbersAPIService);

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      numbersAPIService.getConcreteNumberTrivia(number);

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      numbersAPIService.getRandomNumberTrivia();
}
