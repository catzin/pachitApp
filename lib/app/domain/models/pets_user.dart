// To parse this JSON data, do
//
//     final petsUser = petsUserFromJson(jsonString);

import 'dart:convert';

PetsUser petsUserFromJson(String str) => PetsUser.fromJson(json.decode(str));

String petsUserToJson(PetsUser data) => json.encode(data.toJson());

class PetsUser {
    List<PetU> pets;

    PetsUser({
        required this.pets,
    });

    factory PetsUser.fromJson(Map<String, dynamic> json) => PetsUser(
        pets: List<PetU>.from(json["pets"].map((x) => PetU.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pets": List<dynamic>.from(pets.map((x) => x.toJson())),
    };
}

class PetU {
    int id;
    String nombre;
    String descripcion;
    int estatus;
    String sexo;
    int secureDisable;

    PetU({
        required this.id,
        required this.nombre,
        required this.descripcion,
        required this.estatus,
        required this.sexo,
        required this.secureDisable,
    });

    factory PetU.fromJson(Map<String, dynamic> json) => PetU(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estatus: json["estatus"],
        sexo: json["sexo"],
        secureDisable: json["secureDisable"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estatus": estatus,
        "sexo": sexo,
        "secureDisable": secureDisable,
    };
}
