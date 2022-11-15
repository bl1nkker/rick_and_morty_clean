import 'dart:convert';

import 'package:rick_and_morty_clean/core/error/exception.dart';
import 'package:rick_and_morty_clean/features/data/models/person_model.dart';
import 'package:http/http.dart';

abstract class PersonRemoteDatasource {
  Future<List<PersonModel>> getAllPersons(int page);
  Future<List<PersonModel>> searchPerson(String query);
}

class PersonRemoteDatasourceImpl implements PersonRemoteDatasource {
  final Client client;

  PersonRemoteDatasourceImpl({required this.client});

  @override
  Future<List<PersonModel>> getAllPersons(int page) =>
      _getPersonFromUrl('get endpoint');

  @override
  Future<List<PersonModel>> searchPerson(String query) =>
      _getPersonFromUrl('search endpoint');

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final persons = jsonDecode(response.body);
      return List.from(persons.map((person) => PersonModel.fromJson(person)));
    } else {
      throw ServerException(message: 'Exception on searchPerson');
    }
  }
}
