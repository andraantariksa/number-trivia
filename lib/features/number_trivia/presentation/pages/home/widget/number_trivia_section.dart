import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:number_trivia/common/util/resource.dart';
import 'package:number_trivia/features/number_trivia/domain/entity/number_trivia.dart'
    as entity;
import 'package:number_trivia/features/number_trivia/presentation/pages/home/bloc/home_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/home/bloc/home_state.dart';

class NumberTrivia extends StatelessWidget {
  final entity.NumberTrivia numberTrivia;

  const NumberTrivia({Key? key, required this.numberTrivia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          numberTrivia.number.toString(),
          style: const TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
        ),
        Text(
          numberTrivia.description,
          style: const TextStyle(fontSize: 22.0),
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}

class NumberTriviaSection extends StatelessWidget {
  const NumberTriviaSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => previous.result != current.result,
        builder: (context, state) {
          if (state.result is Loaded<entity.NumberTrivia>) {
            final Loaded<entity.NumberTrivia> result =
                state.result as Loaded<entity.NumberTrivia>;
            return NumberTrivia(numberTrivia: result.data);
          } else if (state.result is Loading<entity.NumberTrivia>) {
            return Lottie.asset("assets/loading.json");
          } else if (state.result is Error<entity.NumberTrivia>) {
            final Error<entity.NumberTrivia> result =
                state.result as Error<entity.NumberTrivia>;
            return Column(children: [
              Lottie.asset("assets/error.json"),
              Text(
                result.exception.toString(),
                textAlign: TextAlign.center,
              )
            ]);
          } else {
            return Lottie.asset("assets/numbers.json");
          }
        });
  }
}
