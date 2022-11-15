import 'package:equatable/equatable.dart';

abstract class Failure implements Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class CacheFailure extends Failure {
  final String message;

  CacheFailure({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
