import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia/features/number_trivia/data/data_source/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/database/database.dart';
import 'package:number_trivia/features/number_trivia/data/exception/cache_exception.dart';
import 'package:number_trivia/features/number_trivia/data/model/number_trivia_model.dart';

class NumberTriviaDatabaseMock extends Mock implements NumberTriviaDatabase {}

void main() {
  const testNumber1 = 420;
  const testNumberTriviaModel1 = NumberTriviaModel(testNumber1, "Test trivia");
  NumberTriviaData testNumberTriviaData1 =
      testNumberTriviaModel1.toNumberTriviaData();

  const testNumber2 = 480;
  const testNumberTriviaModel2 =
      NumberTriviaModel(testNumber2, "Test trivia 2");
  // ignore: unused_local_variable
  NumberTriviaData testNumberTriviaData2 =
      testNumberTriviaModel2.toNumberTriviaData();

  late NumberTriviaDatabase database;
  late NumberTriviaLocalDataSourceImpl dataSource;
  late Map<int, NumberTriviaData> storedData;

  setUp(() {
    registerFallbackValue(testNumberTriviaData1);

    database = NumberTriviaDatabaseMock();
    dataSource = NumberTriviaLocalDataSourceImpl(database);

    storedData = {};

    when(() => database.insertNumberTrivia(any()))
        .thenAnswer((invocation) async {
      final NumberTriviaData data = invocation.positionalArguments.first;
      storedData[data.number] = data;
    });
    when(() => database.getNumberTrivia(any())).thenAnswer((invocation) async {
      final number = invocation.positionalArguments.first;
      return Future.value(storedData[number]);
    });
  });

  group("cacheNumberTrivia", () {
    test("data should be inserted to database", () async {
      await dataSource.cacheNumberTrivia(testNumberTriviaModel1);

      verify(() => database
          .insertNumberTrivia(testNumberTriviaModel1.toNumberTriviaData()));
    });
  });

  group("cacheNumberTrivia", () {
    test("data should be retrieved from database", () async {
      when(() => database.getNumberTrivia(testNumber1))
          .thenAnswer((_) async => testNumberTriviaData1);

      final result = await dataSource.getConcreteNumberTrivia(testNumber1);

      expect(result, testNumberTriviaModel1);
      verify(() => database.getNumberTrivia(testNumber1));
    });
  });

  test("data should be able to be inserted and get from database", () async {
    await dataSource.cacheNumberTrivia(testNumberTriviaModel1);
    await dataSource.cacheNumberTrivia(testNumberTriviaModel2);

    final result =
        await dataSource.getConcreteNumberTrivia(testNumberTriviaModel1.number);

    expect(result, equals(testNumberTriviaModel1));
  });

  test("should throw if there is no found data in the database", () async {
    await dataSource.cacheNumberTrivia(testNumberTriviaModel2);

    final result =
        dataSource.getConcreteNumberTrivia(testNumberTriviaModel1.number);

    expect(result, throwsA(NoCachedDataException()));
  });
}
