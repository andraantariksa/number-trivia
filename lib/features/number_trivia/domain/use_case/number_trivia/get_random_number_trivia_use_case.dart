import 'package:dartz/dartz.dart';
import 'package:number_trivia/features/number_trivia/domain/entity/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repository/number_trivia_repository.dart';

class GetRandomNumberTriviaUseCase {
  final NumberTriviaRepository numberTriviaRepository;

  GetRandomNumberTriviaUseCase(this.numberTriviaRepository);

  Future<Either<Exception, NumberTrivia>> call() async {
    return await numberTriviaRepository.getRandomNumberTrivia();
  }
}
