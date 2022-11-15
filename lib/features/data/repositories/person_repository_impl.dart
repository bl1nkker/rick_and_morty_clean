import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_clean/core/error/exception.dart';
import 'package:rick_and_morty_clean/core/error/failure.dart';
import 'package:rick_and_morty_clean/core/platform/network_info.dart';
import 'package:rick_and_morty_clean/features/data/datasources/person_local_datasource.dart';
import 'package:rick_and_morty_clean/features/data/datasources/person_remote_datasource.dart';
import 'package:rick_and_morty_clean/features/domain/entities/person_entity.dart';
import 'package:rick_and_morty_clean/features/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDatasource personRemoteDatasource;
  final PersonLocalDatasource personLocalDatasource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.personRemoteDatasource,
      required this.personLocalDatasource,
      required this.networkInfo});
  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePersons = await personRemoteDatasource.getAllPersons(page);
        personLocalDatasource.personsToCache(remotePersons);
        return Right(remotePersons);
      } on ServerException {
        return Left(ServerFailure(message: 'Server Failure'));
      }
    } else {
      try {
        final localPersons =
            await personLocalDatasource.getLastPersonsFromCache();
        return Right(localPersons);
      } on CacheException {
        return Left(CacheFailure(message: 'Cache Failure'));
      }
    }
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePersons = await personRemoteDatasource.searchPerson(query);
        personLocalDatasource.personsToCache(remotePersons);
        return Right(remotePersons);
      } on ServerException {
        return Left(ServerFailure(message: 'Server Failure'));
      }
    } else {
      try {
        final localPersons = await personLocalDatasource.searchPersons(query);
        return Right(localPersons);
      } on CacheException {
        return Left(CacheFailure(message: 'Cache Failure'));
      }
    }
  }
}
