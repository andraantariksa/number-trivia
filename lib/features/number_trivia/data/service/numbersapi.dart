import 'package:http/http.dart' as http;
import 'package:number_trivia/features/number_trivia/data/exception/remote_data_exception.dart';
import 'package:number_trivia/features/number_trivia/data/model/number_trivia_model.dart';

abstract class NumbersAPIService {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumbersAPIServiceImpl extends NumbersAPIService {
  static const baseAPI = "http://numbersapi.com";

  final http.Client client;

  NumbersAPIServiceImpl(this.client);

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final resp = await client.get(Uri.parse("$baseAPI/$number/trivia?json"));
    if (resp.statusCode == 200) {
      return NumberTriviaModel.fromJson(resp.body);
    } else {
      throw RemoteDataException(resp.statusCode, resp.body);
    }
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    final resp = await client.get(Uri.parse("$baseAPI/random/trivia?json"));
    if (resp.statusCode == 200) {
      return NumberTriviaModel.fromJson(resp.body);
    } else {
      throw RemoteDataException(resp.statusCode, resp.body);
    }
  }
}
