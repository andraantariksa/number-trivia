import 'package:dartz/dartz.dart';
import 'package:number_trivia/common/error/failures.dart';
import 'package:number_trivia/features/number_trivia/domain/entity/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
