import 'package:equatable/equatable.dart';

abstract class Resource<T> extends Equatable {}

class Loaded<T> extends Resource<T> {
  final T data;

  Loaded(this.data);

  @override
  List<Object?> get props => [data];
}

class Error<T> extends Resource<T> {
  final Exception exception;

  Error(this.exception);

  @override
  List<Object?> get props => [exception];
}

class Loading<T> extends Resource<T> {
  Loading();

  @override
  List<Object?> get props => [];
}
