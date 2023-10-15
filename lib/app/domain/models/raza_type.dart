// To parse this JSON data, do
//
//     final razaType = razaTypeFromJson(jsonString);

import 'dart:convert';

List<RazaType> razaTypeFromJson(String str) => List<RazaType>.from(json.decode(str).map((x) => RazaType.fromJson(x)));

String razaTypeToJson(List<RazaType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RazaType {
    int idtipoRaza;
    String mascota;

    RazaType({
        required this.idtipoRaza,
        required this.mascota,
    });

    factory RazaType.fromJson(Map<String, dynamic> json) => RazaType(
        idtipoRaza: json["idtipoRaza"],
        mascota: json["mascota"],
    );

    Map<String, dynamic> toJson() => {
        "idtipoRaza": idtipoRaza,
        "mascota": mascota,
    };
}
