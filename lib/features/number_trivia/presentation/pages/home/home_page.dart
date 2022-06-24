import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:number_trivia/features/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/home/home_bloc.dart';

class HomePage extends StatelessWidget {
  final NumberTriviaRepository numberTriviaRepository = Get.find();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeBloc();
      },
      child: const HomePageView()
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Trivia"),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        titleTextStyle: TextStyle(color: theme.textTheme.headline1?.color),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Lottie.asset('assets/numbers.json'),
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25.0)),
              child: Container(
                color: theme.secondaryHeaderColor,
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                child: Column(
                  children: [
                    const Text("Enter some number"),
                    TextField(
                      style: TextStyle(
                          backgroundColor: theme.scaffoldBackgroundColor),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Get number trivia"),
                      // minWidth: double.infinity,
                    ),
                    MaterialButton(
                      color: theme.buttonTheme.colorScheme?.onBackground,
                      onPressed: () {},
                      child: const Text("Get random number trivia"),
                      minWidth: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
