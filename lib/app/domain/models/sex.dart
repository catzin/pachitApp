// To parse this JSON data, do
//
//     final sex = sexFromJson(jsonString);

import 'dart:convert';

List<Sex> sexFromJson(String str) => List<Sex>.from(json.decode(str).map((x) => Sex.fromJson(x)));

String sexToJson(List<Sex> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sex {
    Sex({
        required this.idSexo,
        required this.sexo,
    });

    int idSexo;
    String sexo;

    factory Sex.fromJson(Map<String, dynamic> json) => Sex(
        idSexo: json["idSexo"],
        sexo: json["sexo"],
    );

    Map<String, dynamic> toJson() => {
        "idSexo": idSexo,
        "sexo": sexo,
    };
}
