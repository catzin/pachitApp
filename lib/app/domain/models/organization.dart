// To parse this JSON data, do
//
//     final organization = organizationFromJson(jsonString);

import 'dart:convert';

Organization organizationFromJson(String str) => Organization.fromJson(json.decode(str));

String organizationToJson(Organization data) => json.encode(data.toJson());

class Organization {
    Organization({
        this.idusuario,
        required this.nombre,
        required this.descripcion,
        required this.fechaCreacion,
        this.fotoPerfil,
        this.fotoPortada,
        required this.linkDonacion,

    });

    String ?idusuario;
    String nombre;
    String descripcion;
    DateTime fechaCreacion;
    String ?fotoPerfil;
    String ?fotoPortada;
    String linkDonacion;

    factory Organization.fromJson(Map<String, dynamic> json) => Organization(
        idusuario: json["idusuario"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fotoPerfil: json["fotoPerfil"],
        fotoPortada: json["fotoPortada"],

        linkDonacion: json["linkDonacion"],
    );

    Map<String, dynamic> toJson() => {
        "idusuario": idusuario,
        "nombre": nombre,
        "descripcion": descripcion,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "fotoPerfil": fotoPerfil,
        "fotoPortada": fotoPortada,
        "linkDonacion": linkDonacion,
    };
}
