import 'package:equatable/equatable.dart';
import 'package:number_trivia/common/util/resource.dart';
import 'package:number_trivia/features/number_trivia/domain/entity/number_trivia.dart';

class HomeState extends Equatable {
  final String numberText;
  final Resource<NumberTrivia>? result;

  const HomeState({this.numberText = "", this.result});

  @override
  List<Object?> get props => [numberText];
}
