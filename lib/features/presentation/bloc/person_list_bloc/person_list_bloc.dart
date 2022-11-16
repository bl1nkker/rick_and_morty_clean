import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_clean/core/error/failure.dart';
import 'package:rick_and_morty_clean/features/domain/entities/person_entity.dart';
import 'package:rick_and_morty_clean/features/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty_clean/features/presentation/bloc/person_list_bloc/person_list_event.dart';
import 'package:rick_and_morty_clean/features/presentation/bloc/person_list_bloc/person_list_state.dart';

class PersonListBloc extends Bloc<PersonListEvent, PersonListState> {
  final GetAllPersons getAllPersons;
  int page = 1;
  PersonListBloc({required this.getAllPersons
      // initial state
      })
      : super(PersonListEmpty());

  Stream<PersonListState> mapEventToState(PersonListEvent event) async* {
    if (event is PersonList) {
      yield* _mapFetchPersonsToState();
    }
  }

  Stream<PersonListState> _mapFetchPersonsToState() async* {
    var oldPersons = <PersonEntity>[];
    if (state is PersonListSuccess) {
      oldPersons = (state as PersonListSuccess).personsList;
    }

    yield PersonListLoading(
        oldPersonsList: oldPersons, isFirstFetch: page == 1);

    final failureOrPerson =
        await getAllPersons.call(PagePersonParams(page: page));

    yield failureOrPerson.fold(
        (failure) => PersonListError(message: _mapFailureToMessage(failure)),
        (newPersons) {
      page++;
      final persons = (state as PersonListLoading).oldPersonsList;
      persons.addAll(newPersons);
      return PersonListSuccess(personsList: persons);
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.message;
      case CacheFailure:
        return failure.message;
      default:
        return 'Unexpected Message';
    }
  }
}
