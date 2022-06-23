import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia/common/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/data_source/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/data_source/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/exception/server_exception.dart';
import 'package:number_trivia/features/number_trivia/data/model/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/data/repository/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/entity/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repository/number_trivia_repository.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  const testNumber = 420;
  const testNumberTriviaModel =
      NumberTriviaModel(number: testNumber, text: "Test trivia");
  const NumberTrivia testNumberTrivia = testNumberTriviaModel;

  late NumberTriviaRepository repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getConcreteNumberTrivia', () {
    test('check network on call', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getConcreteNumberTrivia(testNumber))
          .thenAnswer((_) async => testNumberTriviaModel);
      when(() => mockLocalDataSource.cacheNumberTrivia(testNumberTriviaModel))
          .thenAnswer((_) async => Future.value());

      await repository.getConcreteNumberTrivia(testNumber);

      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('throw an exception from local', () async {
        when(() => mockLocalDataSource.getConcreteNumberTrivia(testNumber))
            .thenThrow(ServerException());

        final result = await repository.getConcreteNumberTrivia(testNumber);

        verifyNever(
            () => mockRemoteDataSource.getConcreteNumberTrivia(testNumber));
        verify(() => mockLocalDataSource.getConcreteNumberTrivia(testNumber));
        expect(result, equals(Left(ServerException())));
      });

      test('get data from local cache', () async {
        when(() => mockLocalDataSource.getConcreteNumberTrivia(testNumber))
            .thenAnswer((_) async => testNumberTriviaModel);

        final result = await repository.getConcreteNumberTrivia(testNumber);

        expect(result, equals(const Right(testNumberTriviaModel)));
        verify(() => mockLocalDataSource.getConcreteNumberTrivia(testNumber));
        verifyNever(
            () => mockRemoteDataSource.getConcreteNumberTrivia(testNumber));
      });
    });

    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should cache the number trivia and return the result', () async {
        when(() => mockRemoteDataSource.getConcreteNumberTrivia(testNumber))
            .thenAnswer((_) async => testNumberTriviaModel);
        when(() => mockLocalDataSource.cacheNumberTrivia(testNumberTriviaModel))
            .thenAnswer((_) async => Future.value());

        final result = await repository.getConcreteNumberTrivia(testNumber);

        verify(
            () => mockLocalDataSource.cacheNumberTrivia(testNumberTriviaModel));
        verify(() => mockRemoteDataSource.getConcreteNumberTrivia(testNumber));
        expect(result, equals(const Right(testNumberTriviaModel)));
      });
    });
  });
}
