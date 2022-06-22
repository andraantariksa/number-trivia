import 'package:dartz/dartz.dart';
import 'package:number_trivia/features/number_trivia/domain/entity/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Exception, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Exception, NumberTrivia>> getRandomNumberTrivia();
}
