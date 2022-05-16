import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia/features/number_trivia/domain/entity/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/use_case/get_concrete_number_trivia.dart';

class ConcreteNumberTriviaRepositoryMock extends Mock
    implements NumberTriviaRepository {
  ConcreteNumberTriviaRepositoryMock();
}

void main() {
  late NumberTriviaRepository numberTriviaRepository;
  late GetConcreteNumberTrivia useCase;

  setUp(() {
    numberTriviaRepository = ConcreteNumberTriviaRepositoryMock();
    useCase = GetConcreteNumberTrivia(numberTriviaRepository);
  });

  const testNumber = 1;
  const testNumberTrivia = NumberTrivia(text: "Test", number: 1);

  test("should get trivia of a number from the repository", () async {
    when(() => numberTriviaRepository.getConcreteNumberTrivia(any()))
        .thenAnswer((_) async => const Right(testNumberTrivia));

    final result = await useCase(testNumber);

    expect(result, const Right(testNumberTrivia));

    verify(() => numberTriviaRepository.getConcreteNumberTrivia(testNumber));
  });
}
