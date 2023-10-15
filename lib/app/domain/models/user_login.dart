import 'dart:convert';

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
    UserLogin({
        required this.idusuario,
        required this.correo,
        required this.contrasena,
        required this.token,

    });

    String idusuario;
    String correo;
    String contrasena;
    String token;

    factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        idusuario: json["idusuario"],
        correo: json["correo"],
        contrasena: json["contrasena"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "idusuario": idusuario,
        "correo": correo,
        "contrasena": contrasena,
        "token": token,
    };
}
