// To parse this JSON data, do
//
//     final petType = petTypeFromJson(jsonString);

import 'dart:convert';

List<PetType> petTypeFromJson(String str) => List<PetType>.from(json.decode(str).map((x) => PetType.fromJson(x)));

String petTypeToJson(List<PetType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PetType {
    int idtipoMascota;
    String mascota;

    PetType({
        required this.idtipoMascota,
        required this.mascota,
    });

    factory PetType.fromJson(Map<String, dynamic> json) => PetType(
        idtipoMascota: json["idtipoMascota"],
        mascota: json["mascota"],
    );

    Map<String, dynamic> toJson() => {
        "idtipoMascota": idtipoMascota,
        "mascota": mascota,
    };
}
