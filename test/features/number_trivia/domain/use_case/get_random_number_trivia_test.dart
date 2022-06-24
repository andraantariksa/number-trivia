import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia/features/number_trivia/domain/entity/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/use_case/number_trivia/get_random_number_trivia_use_case.dart';

class RandomNumberTriviaRepositoryMock extends Mock
    implements NumberTriviaRepository {
  RandomNumberTriviaRepositoryMock();
}

void main() {
  late NumberTriviaRepository numberTriviaRepository;
  late GetRandomNumberTriviaUseCase useCase;

  setUp(() {
    numberTriviaRepository = RandomNumberTriviaRepositoryMock();
    useCase = GetRandomNumberTriviaUseCase(numberTriviaRepository);
  });

  const testNumberTrivia = NumberTrivia(1, "Test");

  test("should get trivia of a random number from the repository", () async {
    when(() => numberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => const Right(testNumberTrivia));

    final result = await useCase();

    expect(result, equals(const Right(testNumberTrivia)));

    verify(() => numberTriviaRepository.getRandomNumberTrivia());
  });
}
