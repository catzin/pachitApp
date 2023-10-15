// To parse this JSON data, do
//
//     final seguimientos = seguimientosFromJson(jsonString);

import 'dart:convert';

Seguimientos seguimientosFromJson(String str) => Seguimientos.fromJson(json.decode(str));

String seguimientosToJson(Seguimientos data) => json.encode(data.toJson());

class Seguimientos {
    int status;
    List<Seguimiento> seguimientos;

    Seguimientos({
        required this.status,
        required this.seguimientos,
    });

    factory Seguimientos.fromJson(Map<String, dynamic> json) => Seguimientos(
        status: json["status"],
        seguimientos: List<Seguimiento>.from(json["seguimientos"].map((x) => Seguimiento.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "seguimientos": List<dynamic>.from(seguimientos.map((x) => x.toJson())),
    };
}

class Seguimiento {
    String idPeticion;
    DateTime fechaNotificacion;
    bool status;

    Seguimiento({
        required this.idPeticion,
        required this.fechaNotificacion,
        required this.status,
    });

    factory Seguimiento.fromJson(Map<String, dynamic> json) => Seguimiento(
        idPeticion: json["idPeticion"],
        fechaNotificacion: DateTime.parse(json["fechaNotificacion"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "idPeticion": idPeticion,
        "fechaNotificacion": "${fechaNotificacion.year.toString().padLeft(4, '0')}-${fechaNotificacion.month.toString().padLeft(2, '0')}-${fechaNotificacion.day.toString().padLeft(2, '0')}",
        "status": status,
    };
}
