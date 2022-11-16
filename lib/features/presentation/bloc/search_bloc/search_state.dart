import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_clean/features/domain/entities/person_entity.dart';

abstract class PersonSearchState extends Equatable {
  const PersonSearchState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// Initial state
class PersonEmpty extends PersonSearchState {}

// When persons is loading
class PersonSearchLoading extends PersonSearchState {}

class PersonSearchSuccess extends PersonSearchState {
  final List<PersonEntity> persons;
  const PersonSearchSuccess({required this.persons});

  @override
  List<Object?> get props => [persons];
}

class PersonSearchError extends PersonSearchState {
  final String message;
  const PersonSearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
