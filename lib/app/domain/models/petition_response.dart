// To parse this JSON data, do
//
//     final petitionResponse = petitionResponseFromJson(jsonString);

import 'dart:convert';

PetitionResponse petitionResponseFromJson(String str) => PetitionResponse.fromJson(json.decode(str));

String petitionResponseToJson(PetitionResponse data) => json.encode(data.toJson());

class PetitionResponse {
    int status;
    Result result;

    PetitionResponse({
        required this.status,
        required this.result,
    });

    factory PetitionResponse.fromJson(Map<String, dynamic> json) => PetitionResponse(
        status: json["status"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "result": result.toJson(),
    };
}

class Result {
    bool estatus;
    bool finalizada;

    Result({
        required this.estatus,
        required this.finalizada,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        estatus: json["estatus"],
        finalizada: json["finalizada"],
    );

    Map<String, dynamic> toJson() => {
        "estatus": estatus,
        "finalizada": finalizada,
    };
}
