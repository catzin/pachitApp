// To parse this JSON data, do
//
//     final pet = petFromJson(jsonString);

import 'dart:convert';

List<Pet> petFromJson(String str) => List<Pet>.from(json.decode(str).map((x) => Pet.fromJson(x)));

String petToJson(List<Pet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pet {
    int id;
    String nombre;
    String descripcion;
    int estatus;
    String sexo;
    List<MascotaImg> mascotaImgs;
    List<Caracteristica> caracteristicas;
    TipoMascotaIdtipoMascota tipoMascotaIdtipoMascota;
    TipoRazaIdtipoRaza tipoRazaIdtipoRaza;
    NivelActividadIdnivelActividad nivelActividadIdnivelActividad;
    Edad edad;

    Pet({
        required this.id,
        required this.nombre,
        required this.descripcion,
        required this.estatus,
        required this.sexo,
        required this.mascotaImgs,
        required this.caracteristicas,
        required this.tipoMascotaIdtipoMascota,
        required this.tipoRazaIdtipoRaza,
        required this.nivelActividadIdnivelActividad,
        required this.edad,
    });

    factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estatus: json["estatus"],
        sexo: json["sexo"],
        mascotaImgs: List<MascotaImg>.from(json["mascotaImgs"].map((x) => MascotaImg.fromJson(x))),
        caracteristicas: List<Caracteristica>.from(json["caracteristicas"].map((x) => Caracteristica.fromJson(x))),
        tipoMascotaIdtipoMascota: TipoMascotaIdtipoMascota.fromJson(json["tipoMascota_idtipoMascota"]),
        tipoRazaIdtipoRaza: TipoRazaIdtipoRaza.fromJson(json["tipoRaza_idtipoRaza"]),
        nivelActividadIdnivelActividad: NivelActividadIdnivelActividad.fromJson(json["nivelActividad_idnivelActividad"]),
        edad: Edad.fromJson(json["edad"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estatus": estatus,
        "sexo": sexo,
        "mascotaImgs": List<dynamic>.from(mascotaImgs.map((x) => x.toJson())),
        "caracteristicas": List<dynamic>.from(caracteristicas.map((x) => x.toJson())),
        "tipoMascota_idtipoMascota": tipoMascotaIdtipoMascota.toJson(),
        "tipoRaza_idtipoRaza": tipoRazaIdtipoRaza.toJson(),
        "nivelActividad_idnivelActividad": nivelActividadIdnivelActividad.toJson(),
        "edad": edad.toJson(),
    };
}

class Caracteristica {
    int caracteristicaId;
    String nombre;

    Caracteristica({
        required this.caracteristicaId,
        required this.nombre,
    });

    factory Caracteristica.fromJson(Map<String, dynamic> json) => Caracteristica(
        caracteristicaId: json["caracteristicaId"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "caracteristicaId": caracteristicaId,
        "nombre": nombre,
    };
}

class Edad {
    int idEdad;
    String descripcion;

    Edad({
        required this.idEdad,
        required this.descripcion,
    });

    factory Edad.fromJson(Map<String, dynamic> json) => Edad(
        idEdad: json["idEdad"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "idEdad": idEdad,
        "descripcion": descripcion,
    };
}

class MascotaImg {
    String id;
    String nombre;
    String path;
    DateTime fechaSubida;

    MascotaImg({
        required this.id,
        required this.nombre,
        required this.path,
        required this.fechaSubida,
    });

    factory MascotaImg.fromJson(Map<String, dynamic> json) => MascotaImg(
        id: json["id"],
        nombre: json["nombre"],
        path: json["path"],
        fechaSubida: DateTime.parse(json["fechaSubida"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "path": path,
        "fechaSubida": fechaSubida.toIso8601String(),
    };
}

class NivelActividadIdnivelActividad {
    int idnivelActividad;
    String nombre;

    NivelActividadIdnivelActividad({
        required this.idnivelActividad,
        required this.nombre,
    });

    factory NivelActividadIdnivelActividad.fromJson(Map<String, dynamic> json) => NivelActividadIdnivelActividad(
        idnivelActividad: json["idnivelActividad"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "idnivelActividad": idnivelActividad,
        "nombre": nombre,
    };
}

class TipoMascotaIdtipoMascota {
    int idtipoMascota;
    String mascota;

    TipoMascotaIdtipoMascota({
        required this.idtipoMascota,
        required this.mascota,
    });

    factory TipoMascotaIdtipoMascota.fromJson(Map<String, dynamic> json) => TipoMascotaIdtipoMascota(
        idtipoMascota: json["idtipoMascota"],
        mascota: json["mascota"],
    );

    Map<String, dynamic> toJson() => {
        "idtipoMascota": idtipoMascota,
        "mascota": mascota,
    };
}

class TipoRazaIdtipoRaza {
    int idtipoRaza;
    String mascota;

    TipoRazaIdtipoRaza({
        required this.idtipoRaza,
        required this.mascota,
    });

    factory TipoRazaIdtipoRaza.fromJson(Map<String, dynamic> json) => TipoRazaIdtipoRaza(
        idtipoRaza: json["idtipoRaza"],
        mascota: json["mascota"],
    );

    Map<String, dynamic> toJson() => {
        "idtipoRaza": idtipoRaza,
        "mascota": mascota,
    };
}
