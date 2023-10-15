// To parse this JSON data, do
//
//     final recordatorio = recordatorioFromJson(jsonString);

import 'dart:convert';

List<Recordatorio> recordatorioFromJson(String str) => List<Recordatorio>.from(json.decode(str).map((x) => Recordatorio.fromJson(x)));

String recordatorioToJson(List<Recordatorio> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Recordatorio {
    int idrecordatorio;
    String titulo;
    String descripcion;
    DateTime fechaCreacion;
    DateTime? fechaEvento;
    String linkCalendar;

    Recordatorio({
        required this.idrecordatorio,
        required this.titulo,
        required this.descripcion,
        required this.fechaCreacion,
        this.fechaEvento,
        required this.linkCalendar,
    });

    factory Recordatorio.fromJson(Map<String, dynamic> json) => Recordatorio(
        idrecordatorio: json["idrecordatorio"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaEvento: json["fechaEvento"] == null ? null : DateTime.parse(json["fechaEvento"]),
        linkCalendar: json["linkCalendar"],
    );

    Map<String, dynamic> toJson() => {
        "idrecordatorio": idrecordatorio,
        "titulo": titulo,
        "descripcion": descripcion,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "fechaEvento": fechaEvento?.toIso8601String(),
        "vencido": linkCalendar,
    };
}
