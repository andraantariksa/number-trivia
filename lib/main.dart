import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:number_trivia/common/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/data_source/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/data_source/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/database/database.dart';
import 'package:number_trivia/features/number_trivia/data/repository/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/number_trivia/data/service/numbersapi.dart';
import 'package:number_trivia/features/number_trivia/domain/use_case/number_trivia/get_concrete_number_trivia_use_case.dart';
import 'package:number_trivia/features/number_trivia/domain/use_case/number_trivia/get_random_number_trivia_use_case.dart';
import 'package:number_trivia/features/number_trivia/domain/use_case/number_trivia/number_trivia_use_cases.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/home/home_page.dart';

import 'features/number_trivia/domain/repository/number_trivia_repository.dart';

void main() {
  runApp(NumberTriviaApp());
}

class NumberTriviaApp extends StatelessWidget {
  NumberTriviaApp({Key? key}) : super(key: key) {
    setupSingletons();
  }

  void setupSingletons() {
    final client = http.Client();
    final numbersAPIService = NumbersAPIServiceImpl(client);
    Get.put<NumbersAPIService>(numbersAPIService);

    final networkInfo = NetworkInfoImpl(InternetConnectionChecker());
    Get.put<NetworkInfo>(networkInfo);

    final database = NumberTriviaDatabase();
    Get.put<NumberTriviaDatabase>(database);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Test",
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.teal,
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.blue,
          )),
      initialRoute: '/',
      getPages: [
        GetPage(
            name: "/",
            page: () => HomePage(),
            binding: BindingsBuilder(() {
              final repository = NumberTriviaRepositoryImpl(
                  remoteDataSource: NumberTriviaRemoteDataSourceImpl(Get.find()),
                  localDataSource: NumberTriviaLocalDataSourceImpl(Get.find()),
                  networkInfo: Get.find());
              Get.put<NumberTriviaRepository>(repository);

              final numberTriviaUseCases = NumberTriviaUseCases(
                getConcreteNumberTriviaUseCase:
                GetConcreteNumberTriviaUseCase(Get.find()),
                getRandomNumberTriviaUseCase: GetRandomNumberTriviaUseCase(Get.find()),
              );
              Get.put<NumberTriviaUseCases>(numberTriviaUseCases);
            })),
      ],
    );
  }
}
