import 'package:number_trivia/features/number_trivia/domain/use_case/number_trivia/get_concrete_number_trivia_use_case.dart';
import 'package:number_trivia/features/number_trivia/domain/use_case/number_trivia/get_random_number_trivia_use_case.dart';

class NumberTriviaUseCases {
  final GetConcreteNumberTriviaUseCase getConcreteNumberTriviaUseCase;
  final GetRandomNumberTriviaUseCase getRandomNumberTriviaUseCase;

  NumberTriviaUseCases(
      {required this.getConcreteNumberTriviaUseCase,
      required this.getRandomNumberTriviaUseCase});
}
