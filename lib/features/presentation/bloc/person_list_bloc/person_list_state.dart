import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_clean/features/domain/entities/person_entity.dart';

abstract class PersonListState extends Equatable {
  const PersonListState();

  @override
  List<Object?> get props => [];
}

class PersonListEmpty extends PersonListState {
  @override
  List<Object?> get props => [];
}

class PersonListLoading extends PersonListState {
  final List<PersonEntity> oldPersonsList;
  final bool isFirstFetch;

  const PersonListLoading(
      {required this.oldPersonsList, required this.isFirstFetch});
  @override
  List<Object?> get props => [oldPersonsList];
}

class PersonListSuccess extends PersonListState {
  final List<PersonEntity> personsList;

  const PersonListSuccess({required this.personsList});

  @override
  // TODO: implement props
  List<Object?> get props => [personsList];
}

class PersonListError extends PersonListState {
  final String message;
  const PersonListError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
