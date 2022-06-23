import 'package:equatable/equatable.dart';

class NumberTrivia extends Equatable {
  final String description;
  final int number;

  const NumberTrivia(this.number, this.description);

  @override
  List<Object?> get props => [description, number];
}
