
import 'dart:convert';

List<Ocupation> ocupationFromJson(String str) => List<Ocupation>.from(json.decode(str).map((x) => Ocupation.fromJson(x)));

String ocupationToJson(List<Ocupation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ocupation {
    Ocupation({
        required this.idOcupacion,
        required this.ocupacion,
    });

    int idOcupacion;
    String ocupacion;

    factory Ocupation.fromJson(Map<String, dynamic> json) => Ocupation(
        idOcupacion: json["idOcupacion"],
        ocupacion: json["ocupacion"],
    );

    Map<String, dynamic> toJson() => {
        "idOcupacion": idOcupacion,
        "ocupacion": ocupacion,
    };
}
