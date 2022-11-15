import 'dart:convert';

import 'package:rick_and_morty_clean/core/error/exception.dart';
import 'package:rick_and_morty_clean/core/types/cached_types.dart';
import 'package:rick_and_morty_clean/features/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDatasource {
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<List<PersonModel>> searchPersons(String query);
  Future<void> personsToCache(List<PersonModel> persons);
}

class PersonLocalDatasourceImpl implements PersonLocalDatasource {
  final SharedPreferences sharedPreferences;

  PersonLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList = sharedPreferences.getStringList(kCachedPersonsList);
    if (jsonPersonsList != null) {
      return Future.value(jsonPersonsList
          .map((jsonPerson) => PersonModel.fromJson(jsonDecode(jsonPerson)))
          .toList());
    } else {
      throw CacheException(message: 'Exception on getLastPersonsFromCache');
    }
  }

  @override
  Future<List<PersonModel>> searchPersons(String query) {
    final jsonPersonsList = sharedPreferences.getStringList(kCachedPersonsList);
    if (jsonPersonsList != null) {
      // Add Search by query
      return Future.value(jsonPersonsList
          .map((jsonPerson) => PersonModel.fromJson(jsonDecode(jsonPerson)))
          .toList());
    } else {
      throw CacheException(message: 'Exception on getLastPersonsFromCache');
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) async {
    final List<String> jsonPersons =
        persons.map((person) => jsonEncode(person.toJson())).toList();
    await sharedPreferences.setStringList(kCachedPersonsList, jsonPersons);
  }
}
