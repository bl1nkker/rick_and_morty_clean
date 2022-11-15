import 'package:rick_and_morty_clean/features/data/models/location_model.dart';
import 'package:rick_and_morty_clean/features/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  const PersonModel({
    required id,
    required name,
    required status,
    required species,
    required type,
    required gender,
    required origin,
    required location,
    required image,
    required episode,
    required created,
  }) : super(
          id: id,
          name: name,
          status: status,
          species: species,
          type: type,
          gender: gender,
          origin: origin,
          location: location,
          image: image,
          episode: episode,
          created: created,
        );
  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      species: json["species"],
      type: json["type"],
      gender: json["gender"],
      origin: json['origin'] ?? LocationModel.fromJson(json['origin']),
      location: json['location'] ?? LocationModel.fromJson(json['location']),
      image: json["image"],
      episode: List.from(json["episode"].map((e) => e as String)),
      created: DateTime.parse(json["created"]).toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "status": status,
      "species": species,
      "type": type,
      "gender": gender,
      "origin": origin,
      "location": location,
      "image": image,
      "episode": episode,
      "created": created,
    };
  }
}
