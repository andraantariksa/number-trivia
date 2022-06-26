import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NumberTextChanged extends HomeEvent {
  final String numberText;

  NumberTextChanged(this.numberText);
}

class GetConcreteNumberTrivia extends HomeEvent {
  GetConcreteNumberTrivia();
}

class GetRandomNumberTrivia extends HomeEvent {
  GetRandomNumberTrivia();
}
