import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:number_trivia/common/util/resource.dart';
import 'package:number_trivia/features/number_trivia/domain/use_case/number_trivia/number_trivia_use_cases.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/home/bloc/home_event.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NumberTriviaUseCases numberTriviaUseCases = Get.find();

  HomeBloc() : super(const HomeState()) {
    on<NumberTextChanged>(_onNumberTextChange);
    on<GetConcreteNumberTrivia>(_onGetNumberTrivia);
    on<GetRandomNumberTrivia>(_onGetRandomNumberTrivia);
  }

  void _onNumberTextChange(NumberTextChanged event, Emitter<HomeState> emit) {
    emit(HomeState(numberText: event.numberText, result: state.result));
  }

  void _onGetNumberTrivia(
      GetConcreteNumberTrivia event, Emitter<HomeState> emit) async {
    emit(HomeState(numberText: state.numberText, result: Loading()));

    var number = int.tryParse(state.numberText);
    if (number == null) {
      emit(HomeState(
          numberText: state.numberText,
          result: Error(const FormatException())));
      return;
    }
    final result =
        await numberTriviaUseCases.getConcreteNumberTriviaUseCase(number);

    result.fold(
        (error) =>
            emit(HomeState(numberText: state.numberText, result: Error(error))),
        (result) => emit(
            HomeState(numberText: state.numberText, result: Loaded(result))));
  }

  void _onGetRandomNumberTrivia(
      GetRandomNumberTrivia event, Emitter<HomeState> emit) async {
    emit(HomeState(numberText: state.numberText, result: Loading()));

    final result = await numberTriviaUseCases.getRandomNumberTriviaUseCase();

    result.fold(
        (error) =>
            emit(HomeState(numberText: state.numberText, result: Error(error))),
        (result) => emit(
            HomeState(numberText: state.numberText, result: Loaded(result))));
  }
}
