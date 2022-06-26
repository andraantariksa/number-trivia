import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/home/bloc/home_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/home/bloc/home_event.dart';

class NumberTriviaInput extends StatelessWidget {
  const NumberTriviaInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const Text("Enter some number"),
        TextField(
          onChanged: (text) {
            BlocProvider.of<HomeBloc>(context).add(NumberTextChanged(text));
          },
          keyboardType: TextInputType.number,
        ),
        MaterialButton(
          color: theme.primaryColor,
          textColor: theme.scaffoldBackgroundColor,
          onPressed: () {
            BlocProvider.of<HomeBloc>(context).add(GetConcreteNumberTrivia());
          },
          child: const Text("Get number trivia"),
          minWidth: double.infinity,
        ),
        MaterialButton(
          color: theme.primaryColor,
          textColor: theme.scaffoldBackgroundColor,
          onPressed: () {
            BlocProvider.of<HomeBloc>(context).add(GetRandomNumberTrivia());
          },
          child: const Text("Get random number trivia"),
          minWidth: double.infinity,
        ),
      ],
    );
  }
}
