import 'package:equatable/equatable.dart';

abstract class Failure implements Equatable {
  final String message;
  Failure({required this.message});
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure({message}) : super(message: message);

  @override
  List<Object?> get props => [message];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class CacheFailure extends Failure {
  CacheFailure({message}) : super(message: message);

  @override
  List<Object?> get props => [message];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
