// To parse this JSON data, do
//
//     final incidencias = incidenciasFromJson(jsonString);

import 'dart:convert';

Incidencias incidenciasFromJson(String str) => Incidencias.fromJson(json.decode(str));

String incidenciasToJson(Incidencias data) => json.encode(data.toJson());

class Incidencias {
    List<Incidencia> incidencias;

    Incidencias({
        required this.incidencias,
    });

    factory Incidencias.fromJson(Map<String, dynamic> json) => Incidencias(
        incidencias: List<Incidencia>.from(json["incidencias"].map((x) => Incidencia.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "incidencias": List<dynamic>.from(incidencias.map((x) => x.toJson())),
    };
}

class Incidencia {
    int id;
    String descripcion;
    int gasto;
    DateTime fechaCreacion;

    Incidencia({
        required this.id,
        required this.descripcion,
        required this.gasto,
        required this.fechaCreacion,
    });

    factory Incidencia.fromJson(Map<String, dynamic> json) => Incidencia(
        id: json["id"],
        descripcion: json["descripcion"],
        gasto: json["gasto"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "gasto": gasto,
        "fechaCreacion": fechaCreacion.toIso8601String(),
    };
}
