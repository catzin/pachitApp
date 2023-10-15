// To parse this JSON data, do
//
//     final profileAdopt = profileAdoptFromJson(jsonString);

import 'dart:convert';

ProfileAdopt profileAdoptFromJson(String str) => ProfileAdopt.fromJson(json.decode(str));

String profileAdoptToJson(ProfileAdopt data) => json.encode(data.toJson());

class ProfileAdopt {
    int status;
    String message;
    User user;

    ProfileAdopt({
        required this.status,
        required this.message,
        required this.user,
    });

    factory ProfileAdopt.empty() {
    return ProfileAdopt(
      status: 0,
      message: '',
      user: User.empty(),
    );
  }

    factory ProfileAdopt.fromJson(Map<String, dynamic> json) => ProfileAdopt(
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
    String contrasena;
    String fotoPerfil;
    String linkFacebook;
    String linkInstagram;
    bool isactive;
    SexoIdSexo sexoIdSexo;
    EstadoCivilIdEstadoCivil estadoCivilIdEstadoCivil;
    OcupacionIdOcupacion ocupacionIdOcupacion;
    TipoUsuarioIdTipoUsuario tipoUsuarioIdTipoUsuario;
    TipodomicilioIdTipoDomicilio tipodomicilioIdTipoDomicilio;
    Ubicacion ubicacion;
    List<ContactosReferencia> contactosReferencia;

    User({
        required this.idusuario,
        required this.nombre,
        required this.apellidoPaterno,
        required this.apellidoMaterno,
        required this.fechaNacimiento,
        required this.fechaRegistro,
        required this.correo,
        required this.contrasena,
        required this.fotoPerfil,
        required this.linkFacebook,
        required this.linkInstagram,
        required this.isactive,
        required this.sexoIdSexo,
        required this.estadoCivilIdEstadoCivil,
        required this.ocupacionIdOcupacion,
        required this.tipoUsuarioIdTipoUsuario,
        required this.tipodomicilioIdTipoDomicilio,
        required this.ubicacion,
        required this.contactosReferencia,
    });

    factory User.empty() {
    return User(
      idusuario: '',
      nombre: '',
      apellidoPaterno: '',
      apellidoMaterno: '',
      fechaNacimiento: DateTime.now(),
      fechaRegistro: DateTime.now(),
      correo: '',
      contrasena: '',
      fotoPerfil: '',
      linkFacebook: '',
      linkInstagram: '',
      isactive: false,
      sexoIdSexo: SexoIdSexo.empty(),
      estadoCivilIdEstadoCivil: EstadoCivilIdEstadoCivil.empty(),
      ocupacionIdOcupacion: OcupacionIdOcupacion.empty(),
      tipoUsuarioIdTipoUsuario: TipoUsuarioIdTipoUsuario.empty(),
      tipodomicilioIdTipoDomicilio: TipodomicilioIdTipoDomicilio.empty(),
      ubicacion: Ubicacion.empty(),
      contactosReferencia: List.empty()
    );
  }

    

    factory User.fromJson(Map<String, dynamic> json) => User(
        idusuario: json["idusuario"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        correo: json["correo"],
        contrasena: json["contrasena"],
        fotoPerfil: json["fotoPerfil"],
        linkFacebook: json["linkFacebook"],
        linkInstagram: json["linkInstagram"],
        isactive: json["isactive"],
        sexoIdSexo: SexoIdSexo.fromJson(json["sexo_idSexo"]),
        estadoCivilIdEstadoCivil: EstadoCivilIdEstadoCivil.fromJson(json["estadoCivil_idEstadoCivil"]),
        ocupacionIdOcupacion: OcupacionIdOcupacion.fromJson(json["ocupacion_idOcupacion"]),
        tipoUsuarioIdTipoUsuario: TipoUsuarioIdTipoUsuario.fromJson(json["tipoUsuario_idTipoUsuario"]),
        tipodomicilioIdTipoDomicilio: TipodomicilioIdTipoDomicilio.fromJson(json["Tipodomicilio_idTipoDomicilio"]),
        ubicacion: Ubicacion.fromJson(json["ubicacion"]),
        contactosReferencia: List<ContactosReferencia>.from(json["contactosReferencia"].map((x) => ContactosReferencia.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idusuario": idusuario,
        "nombre": nombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "fechaNacimiento": fechaNacimiento.toIso8601String(),
        "fechaRegistro": fechaRegistro.toIso8601String(),
        "correo": correo,
        "contrasena": contrasena,
        "fotoPerfil": fotoPerfil,
        "linkFacebook": linkFacebook,
        "linkInstagram": linkInstagram,
        "isactive": isactive,
        "sexo_idSexo": sexoIdSexo.toJson(),
        "estadoCivil_idEstadoCivil": estadoCivilIdEstadoCivil.toJson(),
        "ocupacion_idOcupacion": ocupacionIdOcupacion.toJson(),
        "tipoUsuario_idTipoUsuario": tipoUsuarioIdTipoUsuario.toJson(),
        "Tipodomicilio_idTipoDomicilio": tipodomicilioIdTipoDomicilio.toJson(),
        "ubicacion": ubicacion.toJson(),
    };
}

class EstadoCivilIdEstadoCivil {
    int idEstadoCivil;
    String estadoCivil;

    EstadoCivilIdEstadoCivil({
        required this.idEstadoCivil,
        required this.estadoCivil,
    });

  factory EstadoCivilIdEstadoCivil.empty() {
    return EstadoCivilIdEstadoCivil(
      idEstadoCivil: 0,
      estadoCivil: '',
    );
  }

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

    factory OcupacionIdOcupacion.empty() {
    return OcupacionIdOcupacion(
      idOcupacion: 0,
      ocupacion: '',
    );
  }

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

    factory SexoIdSexo.empty() {
    return SexoIdSexo(
      idSexo: 0,
      sexo: '',
    );
  }


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

  factory TipoUsuarioIdTipoUsuario.empty() {
    return TipoUsuarioIdTipoUsuario(
      idTipoUsuario: 0,
      usuario: '',
    );
  }

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

    factory TipodomicilioIdTipoDomicilio.empty() {
    return TipodomicilioIdTipoDomicilio(
      idTipoDomicilio: 0,
      domicilio: '',
    );
  }

    factory TipodomicilioIdTipoDomicilio.fromJson(Map<String, dynamic> json) => TipodomicilioIdTipoDomicilio(
        idTipoDomicilio: json["idTipoDomicilio"],
        domicilio: json["domicilio"],
    );

    Map<String, dynamic> toJson() => {
        "idTipoDomicilio": idTipoDomicilio,
        "domicilio": domicilio,
    };
}

class Ubicacion {
    String idUbicacion;
    String street;
    String isoCountryCode;
    String postalCode;
    String administrativeArea;
    String subadministrativeArea;
    String locality;
    String sublocality;
    String thoroughfare;
    String subthoroughfare;
    String lat;
    String lon;

    Ubicacion({
        required this.idUbicacion,
        required this.street,
        required this.isoCountryCode,
        required this.postalCode,
        required this.administrativeArea,
        required this.subadministrativeArea,
        required this.locality,
        required this.sublocality,
        required this.thoroughfare,
        required this.subthoroughfare,
        required this.lat,
        required this.lon,
    });


factory Ubicacion.empty() {
    return Ubicacion(
      idUbicacion: '',
      street: '',
      isoCountryCode: '',
      postalCode: '',
      administrativeArea: '',
      subadministrativeArea: '',
      locality: '',
      sublocality: '',
      thoroughfare: '',
      subthoroughfare: '',
      lat: '',
      lon: '',
    );
  }

    factory Ubicacion.fromJson(Map<String, dynamic> json) => Ubicacion(
        idUbicacion: json["idUbicacion"],
        street: json["street"],
        isoCountryCode: json["ISOCountryCode"],
        postalCode: json["PostalCode"],
        administrativeArea: json["administrativeArea"],
        subadministrativeArea: json["subadministrativeArea"],
        locality: json["locality"],
        sublocality: json["sublocality"],
        thoroughfare: json["thoroughfare"],
        subthoroughfare: json["Subthoroughfare"],
        lat: json["lat"],
        lon: json["lon"],
    );

    Map<String, dynamic> toJson() => {
        "idUbicacion": idUbicacion,
        "street": street,
        "ISOCountryCode": isoCountryCode,
        "PostalCode": postalCode,
        "administrativeArea": administrativeArea,
        "subadministrativeArea": subadministrativeArea,
        "locality": locality,
        "sublocality": sublocality,
        "thoroughfare": thoroughfare,
        "Subthoroughfare": subthoroughfare,
        "lat": lat,
        "lon": lon,
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