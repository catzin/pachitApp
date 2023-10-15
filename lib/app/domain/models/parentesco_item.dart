// To parse this JSON data, do
//
//     final parentescoItem = parentescoItemFromJson(jsonString);

import 'dart:convert';

List<ParentescoItem> parentescoItemFromJson(String str) => List<ParentescoItem>.from(json.decode(str).map((x) => ParentescoItem.fromJson(x)));

String parentescoItemToJson(List<ParentescoItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParentescoItem {
    int idparentesco;
    String parentesco;

    ParentescoItem({
        required this.idparentesco,
        required this.parentesco,
    });

    factory ParentescoItem.fromJson(Map<String, dynamic> json) => ParentescoItem(
        idparentesco: json["idparentesco"],
        parentesco: json["parentesco"],
    );

    Map<String, dynamic> toJson() => {
        "idparentesco": idparentesco,
        "parentesco": parentesco,
    };
}
