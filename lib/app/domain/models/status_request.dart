// To parse this JSON data, do
//
//     final statusRequest = statusRequestFromJson(jsonString);

import 'dart:convert';

import 'package:pachitaapp/app/domain/models/pet.dart';

StatusRequest statusRequestFromJson(String str) => StatusRequest.fromJson(json.decode(str));

String statusRequestToJson(StatusRequest data) => json.encode(data.toJson());

class StatusRequest {
    int status;
    List<Solicitude> solicitudes;

    StatusRequest({
        required this.status,
        required this.solicitudes,
    });

    factory StatusRequest.fromJson(Map<String, dynamic> json) => StatusRequest(
        status: json["status"],
        solicitudes: List<Solicitude>.from(json["solicitudes"].map((x) => Solicitude.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "solicitudes": List<dynamic>.from(solicitudes.map((x) => x.toJson())),
    };
}

class Solicitude {
    int idSolicitudAdopcion;
    DateTime fechaSolicitud;
    int estatus;
    String motivo;
    Mascota mascota;

    Solicitude({
        required this.idSolicitudAdopcion,
        required this.fechaSolicitud,
        required this.estatus,
        required this.motivo,
        required this.mascota,
    });

    factory Solicitude.fromJson(Map<String, dynamic> json) => Solicitude(
        idSolicitudAdopcion: json["idSolicitudAdopcion"],
        fechaSolicitud: DateTime.parse(json["fechaSolicitud"]),
        estatus: json["estatus"],
        motivo: json["motivo"],
        mascota: Mascota.fromJson(json["mascota"]),
    );

    Map<String, dynamic> toJson() => {
        "idSolicitudAdopcion": idSolicitudAdopcion,
        "fechaSolicitud": "${fechaSolicitud.year.toString().padLeft(4, '0')}-${fechaSolicitud.month.toString().padLeft(2, '0')}-${fechaSolicitud.day.toString().padLeft(2, '0')}",
        "estatus": estatus,
        "motivo": motivo,
        "mascota": mascota.toJson(),
    };
}

class Mascota {
    int id;
    String nombre;
    String descripcion;
    int estatus;
    String sexo;
    int secureDisable;
    List<MascotaImg> mascotaImgs;

    Mascota({
        required this.id,
        required this.nombre,
        required this.descripcion,
        required this.estatus,
        required this.sexo,
        required this.secureDisable,
        required this.mascotaImgs,
    });

    factory Mascota.fromJson(Map<String, dynamic> json) => Mascota(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estatus: json["estatus"],
        sexo: json["sexo"],
        secureDisable: json["secureDisable"],
        mascotaImgs: List<MascotaImg>.from(json["mascotaImgs"].map((x) => MascotaImg.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estatus": estatus,
        "sexo": sexo,
        "secureDisable": secureDisable,
        "mascotaImgs": List<dynamic>.from(mascotaImgs.map((x) => x.toJson())),
    };
}

// class MascotaImg {
//     String id;
//     String nombre;
//     String path;
//     DateTime fechaSubida;

//     MascotaImg({
//         required this.id,
//         required this.nombre,
//         required this.path,
//         required this.fechaSubida,
//     });

//     factory MascotaImg.fromJson(Map<String, dynamic> json) => MascotaImg(
//         id: json["id"],
//         nombre: json["nombre"],
//         path: json["path"],
//         fechaSubida: DateTime.parse(json["fechaSubida"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "nombre": nombre,
//         "path": path,
//         "fechaSubida": fechaSubida.toIso8601String(),
//     };
// }
