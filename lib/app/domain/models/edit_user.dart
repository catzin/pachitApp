// To parse this JSON data, do
//
//     final editUser = editUserFromJson(jsonString);

import 'dart:convert';

EditUser editUserFromJson(String str) => EditUser.fromJson(json.decode(str));

String editUserToJson(EditUser data) => json.encode(data.toJson());

class EditUser {
    int status;
    String message;
    User user;

    EditUser({
        required this.status,
        required this.message,
        required this.user,
    });

    factory EditUser.fromJson(Map<String, dynamic> json) => EditUser(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
    };
}

class User {
    String idusuario;
    String nombre;
    String apellidoPaterno;
    String apellidoMaterno;
    DateTime fechaNacimiento;
    DateTime fechaRegistro;
    String correo;
    String fotoPerfil;
    String linkFacebook;
    String linkInstagram;
    String telefono;
    SexoIdSexo sexoIdSexo;
    EstadoCivilIdEstadoCivil estadoCivilIdEstadoCivil;
    OcupacionIdOcupacion ocupacionIdOcupacion;
    TipoUsuarioIdTipoUsuario tipoUsuarioIdTipoUsuario;
    TipodomicilioIdTipoDomicilio tipodomicilioIdTipoDomicilio;
    List<ContactosReferencia> contactosReferencia;
    List<Domicilio> domicilio;
    List<dynamic> mascotaPrevia;
    List<dynamic> documentos;

    User({
        required this.idusuario,
        required this.nombre,
        required this.apellidoPaterno,
        required this.apellidoMaterno,
        required this.fechaNacimiento,
        required this.fechaRegistro,
        required this.correo,
        required this.fotoPerfil,
        required this.linkFacebook,
        required this.linkInstagram,
        required this.telefono,
        required this.sexoIdSexo,
        required this.estadoCivilIdEstadoCivil,
        required this.ocupacionIdOcupacion,
        required this.tipoUsuarioIdTipoUsuario,
        required this.tipodomicilioIdTipoDomicilio,
        required this.contactosReferencia,
        required this.domicilio,
        required this.mascotaPrevia,
        required this.documentos,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        idusuario: json["idusuario"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        correo: json["correo"],
        fotoPerfil: json["fotoPerfil"],
        linkFacebook: json["linkFacebook"],
        linkInstagram: json["linkInstagram"],
        telefono: json["telefono"],
        sexoIdSexo: SexoIdSexo.fromJson(json["sexo_idSexo"]),
        estadoCivilIdEstadoCivil: EstadoCivilIdEstadoCivil.fromJson(json["estadoCivil_idEstadoCivil"]),
        ocupacionIdOcupacion: OcupacionIdOcupacion.fromJson(json["ocupacion_idOcupacion"]),
        tipoUsuarioIdTipoUsuario: TipoUsuarioIdTipoUsuario.fromJson(json["tipoUsuario_idTipoUsuario"]),
        tipodomicilioIdTipoDomicilio: TipodomicilioIdTipoDomicilio.fromJson(json["Tipodomicilio_idTipoDomicilio"]),
        contactosReferencia: List<ContactosReferencia>.from(json["contactosReferencia"].map((x) => ContactosReferencia.fromJson(x))),
        domicilio: List<Domicilio>.from(json["domicilio"].map((x) => Domicilio.fromJson(x))),
        mascotaPrevia: List<dynamic>.from(json["mascotaPrevia"].map((x) => x)),
        documentos: List<dynamic>.from(json["documentos"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "idusuario": idusuario,
        "nombre": nombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "fechaNacimiento": fechaNacimiento.toIso8601String(),
        "fechaRegistro": fechaRegistro.toIso8601String(),
        "correo": correo,
        "fotoPerfil": fotoPerfil,
        "linkFacebook": linkFacebook,
        "linkInstagram": linkInstagram,
        "telefono": telefono,
        "sexo_idSexo": sexoIdSexo.toJson(),
        "estadoCivil_idEstadoCivil": estadoCivilIdEstadoCivil.toJson(),
        "ocupacion_idOcupacion": ocupacionIdOcupacion.toJson(),
        "tipoUsuario_idTipoUsuario": tipoUsuarioIdTipoUsuario.toJson(),
        "Tipodomicilio_idTipoDomicilio": tipodomicilioIdTipoDomicilio.toJson(),
        "contactosReferencia": List<dynamic>.from(contactosReferencia.map((x) => x.toJson())),
        "domicilio": List<dynamic>.from(domicilio.map((x) => x.toJson())),
        "mascotaPrevia": List<dynamic>.from(mascotaPrevia.map((x) => x)),
        "documentos": List<dynamic>.from(documentos.map((x) => x)),
    };
}

class ContactosReferencia {
    String idReferencia;
    String nombre;
    String apellidoPaterno;
    String apellidoMaterno;
    String telefono;
    int active;

    ContactosReferencia({
        required this.idReferencia,
        required this.nombre,
        required this.apellidoPaterno,
        required this.apellidoMaterno,
        required this.telefono,
        required this.active,
    });

    factory ContactosReferencia.fromJson(Map<String, dynamic> json) => ContactosReferencia(
        idReferencia: json["idReferencia"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        telefono: json["telefono"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "idReferencia": idReferencia,
        "nombre": nombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "telefono": telefono,
        "active": active,
    };
}

class Domicilio {
    String idDomicilio;
    String path;

    Domicilio({
        required this.idDomicilio,
        required this.path,
    });

    factory Domicilio.fromJson(Map<String, dynamic> json) => Domicilio(
        idDomicilio: json["idDomicilio"],
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "idDomicilio": idDomicilio,
        "path": path,
    };
}

class EstadoCivilIdEstadoCivil {
    int idEstadoCivil;
    String estadoCivil;

    EstadoCivilIdEstadoCivil({
        required this.idEstadoCivil,
        required this.estadoCivil,
    });

    factory EstadoCivilIdEstadoCivil.fromJson(Map<String, dynamic> json) => EstadoCivilIdEstadoCivil(
        idEstadoCivil: json["idEstadoCivil"],
        estadoCivil: json["estadoCivil"],
    );

    Map<String, dynamic> toJson() => {
        "idEstadoCivil": idEstadoCivil,
        "estadoCivil": estadoCivil,
    };
}

class OcupacionIdOcupacion {
    int idOcupacion;
    String ocupacion;

    OcupacionIdOcupacion({
        required this.idOcupacion,
        required this.ocupacion,
    });

    factory OcupacionIdOcupacion.fromJson(Map<String, dynamic> json) => OcupacionIdOcupacion(
        idOcupacion: json["idOcupacion"],
        ocupacion: json["ocupacion"],
    );

    Map<String, dynamic> toJson() => {
        "idOcupacion": idOcupacion,
        "ocupacion": ocupacion,
    };
}

class SexoIdSexo {
    int idSexo;
    String sexo;

    SexoIdSexo({
        required this.idSexo,
        required this.sexo,
    });

    factory SexoIdSexo.fromJson(Map<String, dynamic> json) => SexoIdSexo(
        idSexo: json["idSexo"],
        sexo: json["sexo"],
    );

    Map<String, dynamic> toJson() => {
        "idSexo": idSexo,
        "sexo": sexo,
    };
}

class TipoUsuarioIdTipoUsuario {
    int idTipoUsuario;
    String usuario;

    TipoUsuarioIdTipoUsuario({
        required this.idTipoUsuario,
        required this.usuario,
    });

    factory TipoUsuarioIdTipoUsuario.fromJson(Map<String, dynamic> json) => TipoUsuarioIdTipoUsuario(
        idTipoUsuario: json["idTipoUsuario"],
        usuario: json["usuario"],
    );

    Map<String, dynamic> toJson() => {
        "idTipoUsuario": idTipoUsuario,
        "usuario": usuario,
    };
}

class TipodomicilioIdTipoDomicilio {
    int idTipoDomicilio;
    String domicilio;

    TipodomicilioIdTipoDomicilio({
        required this.idTipoDomicilio,
        required this.domicilio,
    });

    factory TipodomicilioIdTipoDomicilio.fromJson(Map<String, dynamic> json) => TipodomicilioIdTipoDomicilio(
        idTipoDomicilio: json["idTipoDomicilio"],
        domicilio: json["domicilio"],
    );

    Map<String, dynamic> toJson() => {
        "idTipoDomicilio": idTipoDomicilio,
        "domicilio": domicilio,
    };
}
