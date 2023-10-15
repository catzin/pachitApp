// To parse this JSON data, do
//
//     final caracteristicasType = caracteristicasTypeFromJson(jsonString);

import 'dart:convert';

List<CaracteristicasType> caracteristicasTypeFromJson(String str) => List<CaracteristicasType>.from(json.decode(str).map((x) => CaracteristicasType.fromJson(x)));

String caracteristicasTypeToJson(List<CaracteristicasType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CaracteristicasType {
    int caracteristicaId;
    String nombre;

    CaracteristicasType({
        required this.caracteristicaId,
        required this.nombre,
    });

    factory CaracteristicasType.fromJson(Map<String, dynamic> json) => CaracteristicasType(
        caracteristicaId: json["caracteristicaId"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "caracteristicaId": caracteristicaId,
        "nombre": nombre,
    };
}
