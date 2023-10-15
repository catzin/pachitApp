// To parse this JSON data, do
//
//     final userReponse = userReponseFromJson(jsonString);

import 'dart:convert';

UserReponse userReponseFromJson(String str) => UserReponse.fromJson(json.decode(str));

String userReponseToJson(UserReponse data) => json.encode(data.toJson());

class UserReponse {
    String nombre;
    String apellidoPaterno;
    String apellidoMaterno;
    String correo;
    String idusuario;
    String token;
    int tipoUsuarioIdTipoUsuario;

    UserReponse({
        required this.nombre,
        required this.apellidoPaterno,
        required this.apellidoMaterno,
        required this.correo,
        required this.idusuario,
        required this.token,
        required this.tipoUsuarioIdTipoUsuario,
    });

    factory UserReponse.fromJson(Map<String, dynamic> json) => UserReponse(
        nombre: json["nombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        correo: json["correo"],
        idusuario: json["idusuario"],
        token: json["token"],
        tipoUsuarioIdTipoUsuario: json["tipoUsuario_idTipoUsuario"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "correo": correo,
        "idusuario": idusuario,
        "token": token,
        "tipoUsuario_idTipoUsuario": tipoUsuarioIdTipoUsuario,
    };
}
