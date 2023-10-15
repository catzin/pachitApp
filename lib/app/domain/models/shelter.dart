// To parse this JSON data, do
//
//     final shelter = shelterFromJson(jsonString);

import 'dart:convert';

List<Shelter> shelterFromJson(String str) => List<Shelter>.from(json.decode(str).map((x) => Shelter.fromJson(x)));

String shelterToJson(List<Shelter> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Shelter {
    Shelter({
        required this.idorganizacion,
        required this.nombre,
        required this.descripcion,
        required this.fechaCreacion,
        required this.linkInstagram,
        required this.linkFacebook,
        required this.fotoPerfil,
        required this.linkWeb,
        required this.fotoPortada,
        required this.estatus,
        this.linkDonacion,
    });

    String idorganizacion;
    String nombre;
    String descripcion;
    DateTime fechaCreacion;
    String linkInstagram;
    String linkFacebook;
    String fotoPerfil;
    String linkWeb;
    String fotoPortada;
    int estatus;
    dynamic linkDonacion;

    factory Shelter.fromJson(Map<String, dynamic> json) => Shelter(
        idorganizacion: json["idorganizacion"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        linkInstagram: json["linkInstagram"],
        linkFacebook: json["linkFacebook"],
        fotoPerfil: json["fotoPerfil"],
        linkWeb: json["linkWeb"],
        fotoPortada: json["fotoPortada"],
        estatus: json["estatus"],
        linkDonacion: json["linkDonacion"],
    );

    Map<String, dynamic> toJson() => {
        "idorganizacion": idorganizacion,
        "nombre": nombre,
        "descripcion": descripcion,
        "fechaCreacion": "${fechaCreacion.year.toString().padLeft(4, '0')}-${fechaCreacion.month.toString().padLeft(2, '0')}-${fechaCreacion.day.toString().padLeft(2, '0')}",
        "linkInstagram": linkInstagram,
        "linkFacebook": linkFacebook,
        "fotoPerfil": fotoPerfil,
        "linkWeb": linkWeb,
        "fotoPortada": fotoPortada,
        "estatus": estatus,
        "linkDonacion": linkDonacion,
    };
}
