// To parse this JSON data, do
//
//     final nivelActividad = nivelActividadFromJson(jsonString);

import 'dart:convert';

List<NivelActividad> nivelActividadFromJson(String str) => List<NivelActividad>.from(json.decode(str).map((x) => NivelActividad.fromJson(x)));

String nivelActividadToJson(List<NivelActividad> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NivelActividad {
    int idnivelActividad;
    String nombre;

    NivelActividad({
        required this.idnivelActividad,
        required this.nombre,
    });

    factory NivelActividad.fromJson(Map<String, dynamic> json) => NivelActividad(
        idnivelActividad: json["idnivelActividad"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "idnivelActividad": idnivelActividad,
        "nombre": nombre,
    };
}
