// ignore: file_names
import 'dart:convert';
import 'package:pachitaapp/app/domain/models/pet.dart';

LikedPet likedPetFromJson(String str) => LikedPet.fromJson(json.decode(str));

String likedPetToJson(LikedPet data) => json.encode(data.toJson());

class LikedPet {
  int status;
  List<Petl> pets;

  LikedPet({
    required this.status,
    required this.pets,
  });

  factory LikedPet.fromJson(Map<String, dynamic> json) => LikedPet(
        status: json["status"],
        pets: List<Petl>.from(json["pets"].map((x) => Petl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "pets": List<dynamic>.from(pets.map((x) => x.toJson())),
      };
}

class Petl {
  int idMascotaUsuario;
  Mascota mascota;

  Petl({
    required this.idMascotaUsuario,
    required this.mascota,
  });

  factory Petl.fromJson(Map<String, dynamic> json) => Petl(
        idMascotaUsuario: json["idMascotaUsuario"],
        mascota: Mascota.fromJson(json["mascota"]),
      );

  Map<String, dynamic> toJson() => {
        "idMascotaUsuario": idMascotaUsuario,
        "mascota": mascota.toJson(),
      };
}

class Mascota {
  int id;
  String nombre;
  String descripcion;
  int estatus;
  String sexo;
  int secureDisable;
  List<MascotaImg> mascotaImgs;

  Mascota({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.estatus,
    required this.sexo,
    required this.secureDisable,
    required this.mascotaImgs,
  });

  factory Mascota.fromJson(Map<String, dynamic> json) => Mascota(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estatus: json["estatus"],
        sexo: json["sexo"],
        secureDisable: json["secureDisable"],
        mascotaImgs: json["mascotaImgs"] != null ?  List<MascotaImg>.from(
            json["mascotaImgs"].map((x) => MascotaImg.fromJson(x))) : []
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estatus": estatus,
        "sexo": sexo,
        "secureDisable": secureDisable,
        "mascotaImgs":
            List<dynamic>.from(mascotaImgs.map((x) => x.toJson())),
      };
}


