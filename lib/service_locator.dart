import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty_clean/core/platform/network_info.dart';
import 'package:rick_and_morty_clean/features/data/datasources/person_local_datasource.dart';
import 'package:rick_and_morty_clean/features/data/datasources/person_remote_datasource.dart';
import 'package:rick_and_morty_clean/features/data/repositories/person_repository_impl.dart';
import 'package:rick_and_morty_clean/features/domain/repositories/person_repository.dart';
import 'package:rick_and_morty_clean/features/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty_clean/features/domain/usecases/search_person.dart';
import 'package:rick_and_morty_clean/features/presentation/bloc/person_list_bloc/person_list_bloc.dart';
import 'package:rick_and_morty_clean/features/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

init() async {
  // State Managements
  sl.registerFactory(() => PersonListBloc(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()));

  // Usecases

  // Immediately after app runs
  // sl.registerSingleton(instance)

  // Only after it needs
  sl.registerLazySingleton<GetAllPersons>(() => GetAllPersons(sl()));
  sl.registerLazySingleton<SearchPerson>(() => SearchPerson(sl()));

  // Repositories
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
      personRemoteDatasource: sl(),
      personLocalDatasource: sl(),
      networkInfo: sl()));
  sl.registerLazySingleton<PersonRemoteDatasource>(
      () => PersonRemoteDatasourceImpl(client: sl()));

  sl.registerLazySingleton<PersonLocalDatasource>(
      () => PersonLocalDatasourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  // External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
}
