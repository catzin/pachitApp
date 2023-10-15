// To parse this JSON data, do
//
//     final residence = residenceFromJson(jsonString);

import 'dart:convert';

List<Residence> residenceFromJson(String str) => List<Residence>.from(json.decode(str).map((x) => Residence.fromJson(x)));

String residenceToJson(List<Residence> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Residence {
    Residence({
        required this.idTipoDomicilio,
        required this.domicilio,
    });

    int idTipoDomicilio;
    String domicilio;

    factory Residence.fromJson(Map<String, dynamic> json) => Residence(
        idTipoDomicilio: json["idTipoDomicilio"],
        domicilio: json["domicilio"],
    );

    Map<String, dynamic> toJson() => {
        "idTipoDomicilio": idTipoDomicilio,
        "domicilio": domicilio,
    };
}
