import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia/features/number_trivia/data/exception/remote_data_exception.dart';
import 'package:number_trivia/features/number_trivia/data/model/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/data/service/numbersapi.dart';

import '../../../../fixtures/fixtures.dart';

class HttpClientMock extends Mock implements http.Client {}

class UriMock extends Mock implements Uri {}

void main() {
  const testNumber = 418;
  const testNumberTriviaModel = NumberTriviaModel(
      number: testNumber,
      text:
          "418 is the error code for \"I\'m a teapot\" in the Hyper Text Coffee Pot Control Protocol.");

  const errorCode = 404;
  const errorMessage = "Something went wrong";
  const errorException = RemoteDataException(errorCode, errorMessage);

  late NumbersAPIServiceImpl service;
  late http.Client httpClient;

  setUp(() {
    registerFallbackValue(UriMock());

    httpClient = HttpClientMock();
    service = NumbersAPIServiceImpl(httpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(() => httpClient.get(any())).thenAnswer(
        (_) async => http.Response(fixtureString('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(() => httpClient.get(any()))
        .thenAnswer((_) async => http.Response(errorMessage, errorCode));
  }

  group("getConcreteNumberTrivia", () {
    test("success", () async {
      setUpMockHttpClientSuccess200();

      final result = await service.getConcreteNumberTrivia(testNumber);

      expect(testNumberTriviaModel, equals(result));
    });

    test("failed", () async {
      setUpMockHttpClientFailure404();

      final result = service.getConcreteNumberTrivia(testNumber);

      await expectLater(result, throwsA(errorException));
    });
  });

  group("getRandomNumberTrivia", () {
    test("success", () async {
      setUpMockHttpClientSuccess200();

      final result = await service.getRandomNumberTrivia();

      expect(testNumberTriviaModel, equals(result));
    });

    test("failed", () async {
      setUpMockHttpClientFailure404();

      final result = service.getRandomNumberTrivia();

      await expectLater(result, throwsA(errorException));
    });
  });
}
