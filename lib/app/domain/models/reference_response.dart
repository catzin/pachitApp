// To parse this JSON data, do
//
//     final referenceResponse = referenceResponseFromJson(jsonString);

import 'dart:convert';

ReferenceResponse referenceResponseFromJson(String str) => ReferenceResponse.fromJson(json.decode(str));

String referenceResponseToJson(ReferenceResponse data) => json.encode(data.toJson());

class ReferenceResponse {
    int statusCode;
    String message;
    User user;

    ReferenceResponse({
        required this.statusCode,
        required this.message,
        required this.user,
    });

    factory ReferenceResponse.fromJson(Map<String, dynamic> json) => ReferenceResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "user": user.toJson(),
    };
}

class User {
    String nombre;
    String apellidoPaterno;
    String apellidoMaterno;
    String telefono;
    int active;
    ParentescoIdParentesco parentescoIdParentesco;
    String idReferencia;

    User({
        required this.nombre,
        required this.apellidoPaterno,
        required this.apellidoMaterno,
        required this.telefono,
        required this.active,
        required this.parentescoIdParentesco,
        required this.idReferencia,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        nombre: json["nombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        telefono: json["telefono"],
        active: json["active"],
        parentescoIdParentesco: ParentescoIdParentesco.fromJson(json["parentesco_idParentesco"]),
        idReferencia: json["idReferencia"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "telefono": telefono,
        "active": active,
        "parentesco_idParentesco": parentescoIdParentesco.toJson(),
        "idReferencia": idReferencia,
    };
}

class ParentescoIdParentesco {
    int idparentesco;
    String parentesco;

    ParentescoIdParentesco({
        required this.idparentesco,
        required this.parentesco,
    });

    factory ParentescoIdParentesco.fromJson(Map<String, dynamic> json) => ParentescoIdParentesco(
        idparentesco: json["idparentesco"],
        parentesco: json["parentesco"],
    );

    Map<String, dynamic> toJson() => {
        "idparentesco": idparentesco,
        "parentesco": parentesco,
    };
}
