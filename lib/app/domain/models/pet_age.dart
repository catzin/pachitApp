// To parse this JSON data, do
//
//     final petAgeResponse = petAgeResponseFromJson(jsonString);

import 'dart:convert';

List<PetAgeResponse> petAgeResponseFromJson(String str) => List<PetAgeResponse>.from(json.decode(str).map((x) => PetAgeResponse.fromJson(x)));

String petAgeResponseToJson(List<PetAgeResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PetAgeResponse {
    int idEdad;
    String descripcion;

    PetAgeResponse({
        required this.idEdad,
        required this.descripcion,
    });

    factory PetAgeResponse.fromJson(Map<String, dynamic> json) => PetAgeResponse(
        idEdad: json["idEdad"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "idEdad": idEdad,
        "descripcion": descripcion,
    };
}
