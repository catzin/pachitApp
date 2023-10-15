import 'dart:convert';
import 'likedPet.dart';

AdoptionRequest adoptionRequestFromJson(String str) => AdoptionRequest.fromJson(json.decode(str));

String adoptionRequestToJson(AdoptionRequest data) => json.encode(data.toJson());

class AdoptionRequest {
    int status;
    String message;
    Accept accept;

    AdoptionRequest({
        required this.status,
        required this.message,
        required this.accept,
    });

    factory AdoptionRequest.fromJson(Map<String, dynamic> json) => AdoptionRequest(
        status: json["status"],
        message: json["message"],
        accept: Accept.fromJson(json["accept"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "accept": accept.toJson(),
    };
}

class Accept {
    DateTime fechaSolicitud;
    int estatus;
    String motivo;
    Mascota mascota;
    int idSolicitudAdopcion;

    Accept({
        required this.fechaSolicitud,
        required this.estatus,
        required this.motivo,
        required this.mascota,
        required this.idSolicitudAdopcion,
    });

    factory Accept.fromJson(Map<String, dynamic> json) => Accept(
        fechaSolicitud: DateTime.parse(json["fechaSolicitud"]),
        estatus: json["estatus"],
        motivo: json["motivo"],
        mascota: Mascota.fromJson(json["mascota"]),
        idSolicitudAdopcion: json["idSolicitudAdopcion"],
    );

    Map<String, dynamic> toJson() => {
        "fechaSolicitud": fechaSolicitud.toIso8601String(),
        "estatus": estatus,
        "motivo": motivo,
        "mascota": mascota.toJson(),
        "idSolicitudAdopcion": idSolicitudAdopcion,
    };
}

