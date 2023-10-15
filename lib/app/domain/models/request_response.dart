// To parse this JSON data, do
//
//     final requestResponse = requestResponseFromJson(jsonString);

import 'dart:convert';

RequestResponse requestResponseFromJson(String str) => RequestResponse.fromJson(json.decode(str));

String requestResponseToJson(RequestResponse data) => json.encode(data.toJson());

class RequestResponse {
    int status;
    String id;
    String message;

    RequestResponse({
        required this.status,
        required this.id,
        required this.message,
    });

    factory RequestResponse.fromJson(Map<String, dynamic> json) => RequestResponse(
        status: json["status"],
        id: json["id"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "message": message,
    };
}
