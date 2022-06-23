import 'package:number_trivia/features/number_trivia/data/database/database.dart';
import 'package:number_trivia/features/number_trivia/data/exception/cache_exception.dart';
import 'package:number_trivia/features/number_trivia/data/model/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaToCache);
}

class NumberTriviaLocalDataSourceImpl extends NumberTriviaLocalDataSource {
  final NumberTriviaDatabase database;

  NumberTriviaLocalDataSourceImpl(this.database);

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaToCache) async =>
      await database
          .insertNumberTrivia(numberTriviaToCache.toNumberTriviaData());

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final data = await database.getNumberTrivia(number);
    if (data == null) {
      throw NoCachedDataException();
    }
    return NumberTriviaModel.fromNumberTriviaData(data);
  }
}
