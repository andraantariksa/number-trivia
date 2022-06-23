import 'package:dartz/dartz.dart';
import 'package:number_trivia/common/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/data_source/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/data_source/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/exception/no_connection_exception.dart';
import 'package:number_trivia/features/number_trivia/domain/entity/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repository/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Exception, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteResult =
            await remoteDataSource.getConcreteNumberTrivia(number);
        await localDataSource.cacheNumberTrivia(remoteResult);
        return Right(remoteResult);
      } else {
        final localResult =
            await localDataSource.getConcreteNumberTrivia(number);
        return Right(localResult);
      }
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, NumberTrivia>> getRandomNumberTrivia() async {
    if (!(await networkInfo.isConnected)) {
      return Left(NoConnectionException());
    }
    try {
      final result = await remoteDataSource.getRandomNumberTrivia();
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
