// To parse this JSON data, do
//
//     final changeStatus = changeStatusFromJson(jsonString);

import 'dart:convert';

ChangeStatus changeStatusFromJson(String str) => ChangeStatus.fromJson(json.decode(str));

String changeStatusToJson(ChangeStatus data) => json.encode(data.toJson());

class ChangeStatus {
    int status;
    String message;
    Solicitud solicitud;

    ChangeStatus({
        required this.status,
        required this.message,
        required this.solicitud,
    });

    factory ChangeStatus.fromJson(Map<String, dynamic> json) => ChangeStatus(
        status: json["status"],
        message: json["message"],
        solicitud: Solicitud.fromJson(json["solicitud"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "solicitud": solicitud.toJson(),
    };
}

class Solicitud {
    int id;
    String estatus;

    Solicitud({
        required this.id,
        required this.estatus,
    });

    factory Solicitud.fromJson(Map<String, dynamic> json) => Solicitud(
        id: json["id"],
        estatus: json["estatus"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "estatus": estatus,
    };
}
