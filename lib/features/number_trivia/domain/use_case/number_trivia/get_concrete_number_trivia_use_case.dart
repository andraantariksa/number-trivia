import 'package:dartz/dartz.dart';
import 'package:number_trivia/features/number_trivia/domain/entity/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repository/number_trivia_repository.dart';

class GetConcreteNumberTriviaUseCase {
  final NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTriviaUseCase(this.numberTriviaRepository);

  Future<Either<Exception, NumberTrivia>> call(int number) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(number);
  }
}
