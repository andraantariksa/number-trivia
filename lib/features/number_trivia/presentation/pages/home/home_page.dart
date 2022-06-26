import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:number_trivia/features/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/home/bloc/home_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/home/widget/number_trivia_input.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/home/widget/number_trivia_section.dart';

class HomePage extends StatelessWidget {
  final NumberTriviaRepository numberTriviaRepository = Get.find();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return HomeBloc();
        },
        child: const HomePageView());
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
        create: (context) => HomeBloc(),
        child: SafeArea(
            child: Scaffold(
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
                const Expanded(child: NumberTriviaSection()),
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(25.0)),
                  child: Container(
                    color: theme.secondaryHeaderColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    child: const NumberTriviaInput(),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
