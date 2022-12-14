import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_clean/core/error/failure.dart';
import 'package:rick_and_morty_clean/features/domain/usecases/search_person.dart';
import 'package:rick_and_morty_clean/features/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty_clean/features/presentation/bloc/search_bloc/search_state.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;
  PersonSearchBloc({required this.searchPerson
      // initial state
      })
      : super(PersonEmpty());

  Stream<PersonSearchState> mapEventToState(PersonSearchEvent event) async* {
    if (event is SearchPersons) {
      yield* _mapFetchPersonsToState(event.personQuery);
    }
  }

  Stream<PersonSearchState> _mapFetchPersonsToState(String personQuery) async* {
    yield PersonSearchLoading();

    final failureOrPerson =
        await searchPerson.call(SearchPersonParams(query: personQuery));

    yield failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchSuccess(persons: person));
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
