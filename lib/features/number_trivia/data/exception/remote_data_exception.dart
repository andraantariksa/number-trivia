import 'package:equatable/equatable.dart';

class RemoteDataException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const RemoteDataException(this.statusCode, this.message);

  @override
  List<Object?> get props => [message, statusCode];
}
