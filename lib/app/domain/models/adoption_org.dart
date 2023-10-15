// To parse this JSON data, do
//
//     final adoptionOrgRequest = adoptionOrgRequestFromJson(jsonString);

import 'dart:convert';

AdoptionOrgRequest adoptionOrgRequestFromJson(String str) => AdoptionOrgRequest.fromJson(json.decode(str));

String adoptionOrgRequestToJson(AdoptionOrgRequest data) => json.encode(data.toJson());

class AdoptionOrgRequest {
    int status;
    String message;
    List<PetOrgRequest> pets;

    AdoptionOrgRequest({
        required this.status,
        required this.message,
        required this.pets,
    });

    factory AdoptionOrgRequest.fromJson(Map<String, dynamic> json) => AdoptionOrgRequest(
        status: json["status"],
        message: json["message"],
        pets: List<PetOrgRequest>.from(json["pets"].map((x) => PetOrgRequest.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "pets": List<dynamic>.from(pets.map((x) => x.toJson())),
    };
}

class PetOrgRequest {
    int mascotaId;
    String mascotaNombre;
    String mascotaImgsId;
    String mascotaImgsNombre;
    String mascotaImgsPath;
    DateTime mascotaImgsFechaSubida;

    PetOrgRequest({
        required this.mascotaId,
        required this.mascotaNombre,
        required this.mascotaImgsId,
        required this.mascotaImgsNombre,
        required this.mascotaImgsPath,
        required this.mascotaImgsFechaSubida,
    });

    factory PetOrgRequest.fromJson(Map<String, dynamic> json) => PetOrgRequest(
        mascotaId: json["mascota_id"],
        mascotaNombre: json["mascota_nombre"],
        mascotaImgsId: json["mascotaImgs_id"],
        mascotaImgsNombre: json["mascotaImgs_nombre"],
        mascotaImgsPath: json["mascotaImgs_path"],
        mascotaImgsFechaSubida: DateTime.parse(json["mascotaImgs_fechaSubida"]),
    );

    Map<String, dynamic> toJson() => {
        "mascota_id": mascotaId,
        "mascota_nombre": mascotaNombre,
        "mascotaImgs_id": mascotaImgsId,
        "mascotaImgs_nombre": mascotaImgsNombre,
        "mascotaImgs_path": mascotaImgsPath,
        "mascotaImgs_fechaSubida": mascotaImgsFechaSubida.toIso8601String(),
    };
}
