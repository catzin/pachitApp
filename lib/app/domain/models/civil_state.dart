// To parse this JSON data, do
//
//     final civilState = civilStateFromJson(jsonString);

import 'dart:convert';

List<CivilState> civilStateFromJson(String str) => List<CivilState>.from(json.decode(str).map((x) => CivilState.fromJson(x)));

String civilStateToJson(List<CivilState> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CivilState {
    CivilState({
        required this.idEstadoCivil,
        required this.estadoCivil,
    });

    int idEstadoCivil;
    String estadoCivil;

    factory CivilState.fromJson(Map<String, dynamic> json) => CivilState(
        idEstadoCivil: json["idEstadoCivil"],
        estadoCivil: json["estadoCivil"],
    );

    Map<String, dynamic> toJson() => {
        "idEstadoCivil": idEstadoCivil,
        "estadoCivil": estadoCivil,
    };
}
