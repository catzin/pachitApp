// To parse this JSON data, do
//
//     final evidenceResponse = evidenceResponseFromJson(jsonString);

import 'dart:convert';

EvidenceResponse evidenceResponseFromJson(String str) => EvidenceResponse.fromJson(json.decode(str));

String evidenceResponseToJson(EvidenceResponse data) => json.encode(data.toJson());

class EvidenceResponse {
    List<Result> result;

    EvidenceResponse({
        required this.result,
    });

    factory EvidenceResponse.fromJson(Map<String, dynamic> json) => EvidenceResponse(
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Result {
    String idDomicilio;
    String path;

    Result({
        required this.idDomicilio,
        required this.path,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        idDomicilio: json["idDomicilio"],
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "idDomicilio": idDomicilio,
        "path": path,
    };
}
