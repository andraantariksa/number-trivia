import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia/features/number_trivia/data/data_source/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/model/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/data/service/numbersapi.dart';

class NumbersAPIServiceMock extends Mock implements NumbersAPIService {}

void main() {
  const testNumber = 420;
  const testNumberTriviaModel =
      NumberTriviaModel(number: testNumber, text: "Test trivia");

  late NumbersAPIService apiService;
  late NumberTriviaRemoteDataSourceImpl dataSource;

  setUp(() {
    apiService = NumbersAPIServiceMock();
    dataSource = NumberTriviaRemoteDataSourceImpl(apiService);
  });

  test("getConcreteNumberTrivia", () async {
    when(() => apiService.getConcreteNumberTrivia(testNumber))
        .thenAnswer((_) async => testNumberTriviaModel);

    await dataSource.getConcreteNumberTrivia(testNumber);

    verify(() => apiService.getConcreteNumberTrivia(testNumber));
  });

  test("getRandomNumberTrivia", () async {
    when(() => apiService.getRandomNumberTrivia())
        .thenAnswer((_) async => testNumberTriviaModel);

    await dataSource.getRandomNumberTrivia();

    verify(() => apiService.getRandomNumberTrivia());
  });
}
