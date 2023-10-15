import 'dart:convert';

RequestByPet requestByPetFromJson(String str) => RequestByPet.fromJson(json.decode(str));

String requestByPetToJson(RequestByPet data) => json.encode(data.toJson());

class RequestByPet {
    int status;
    List<RequestPet> request;

    RequestByPet({
        required this.status,
        required this.request,
    });

    factory RequestByPet.fromJson(Map<String, dynamic> json) => RequestByPet(
        status: json["status"],
        request: List<RequestPet>.from(json["request"].map((x) => RequestPet.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "request": List<dynamic>.from(request.map((x) => x.toJson())),
    };
}

class RequestPet {
    int idSolicitudAdopcion;
    DateTime fechaSolicitud;
    int estatus;
    String motivo;
    UsuarioRequesPet usuario;

    RequestPet({
        required this.idSolicitudAdopcion,
        required this.fechaSolicitud,
        required this.estatus,
        required this.motivo,
        required this.usuario,
    });

    factory RequestPet.fromJson(Map<String, dynamic> json) => RequestPet(
        idSolicitudAdopcion: json["idSolicitudAdopcion"],
        fechaSolicitud: DateTime.parse(json["fechaSolicitud"]),
        estatus: json["estatus"],
        motivo: json["motivo"],
        usuario: UsuarioRequesPet.fromJson(json["usuario"]),
    );

    Map<String, dynamic> toJson() => {
        "idSolicitudAdopcion": idSolicitudAdopcion,
        "fechaSolicitud": "${fechaSolicitud.year.toString().padLeft(4, '0')}-${fechaSolicitud.month.toString().padLeft(2, '0')}-${fechaSolicitud.day.toString().padLeft(2, '0')}",
        "estatus": estatus,
        "motivo": motivo,
        "usuario": usuario.toJson(),
    };
}

class UsuarioRequesPet {
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
    String telefono;
    bool isactive;
    String roles;
    UbicacionRequestPet ubicacion;
    List<ContactosReferencia> contactosReferencia;
    Horariocontacto horariocontacto;
    List<Domicilio> domicilio;
    List<MascotaPrevia> mascotaPrevia;
    List<Documento> documentos;
    EstadoCivilIdEstadoCivil estadoCivilIdEstadoCivil;
    SexoIdSexo sexoIdSexo;
    OcupacionIdOcupacion ocupacionIdOcupacion;
    TipodomicilioIdTipoDomicilio tipodomicilioIdTipoDomicilio;

    UsuarioRequesPet({
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
        required this.telefono,
        required this.isactive,
        required this.roles,
        required this.ubicacion,
        required this.contactosReferencia,
        required this.horariocontacto,
        required this.domicilio,
        required this.mascotaPrevia,
        required this.documentos,
        required this.estadoCivilIdEstadoCivil,
        required this.sexoIdSexo,
        required this.ocupacionIdOcupacion,
        required this.tipodomicilioIdTipoDomicilio,
    });

    factory UsuarioRequesPet.fromJson(Map<String, dynamic> json) => UsuarioRequesPet(
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
        telefono: json["telefono"],
        isactive: json["isactive"],
        roles: json["roles"],
        ubicacion: UbicacionRequestPet.fromJson(json["ubicacion"]),
        contactosReferencia: List<ContactosReferencia>.from(json["contactosReferencia"].map((x) => ContactosReferencia.fromJson(x))),
        horariocontacto: json['horariocontacto'] == null
    ? Horariocontacto(idhorarioContacto: " ", especificacion: " ")
    : Horariocontacto.fromJson(json["horariocontacto"]),

        

        domicilio: List<Domicilio>.from(json["domicilio"].map((x) => Domicilio.fromJson(x))),
        mascotaPrevia: List<MascotaPrevia>.from(json["mascotaPrevia"].map((x) => MascotaPrevia.fromJson(x))),
        documentos: List<Documento>.from(json["documentos"].map((x) => Documento.fromJson(x))),
        estadoCivilIdEstadoCivil: EstadoCivilIdEstadoCivil.fromJson(json["estadoCivil_idEstadoCivil"]),
        sexoIdSexo: SexoIdSexo.fromJson(json["sexo_idSexo"]),
        ocupacionIdOcupacion: OcupacionIdOcupacion.fromJson(json["ocupacion_idOcupacion"]),
        tipodomicilioIdTipoDomicilio: TipodomicilioIdTipoDomicilio.fromJson(json["Tipodomicilio_idTipoDomicilio"]),
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
        "telefono": telefono,
        "isactive": isactive,
        "roles": roles,
        "ubicacion": ubicacion.toJson(),
        "contactosReferencia": List<dynamic>.from(contactosReferencia.map((x) => x.toJson())),
        "horariocontacto": horariocontacto.toJson(),
        "domicilio": List<dynamic>.from(domicilio.map((x) => x.toJson())),
        "mascotaPrevia": List<dynamic>.from(mascotaPrevia.map((x) => x.toJson())),
        "documentos": List<dynamic>.from(documentos.map((x) => x.toJson())),
        "estadoCivil_idEstadoCivil": estadoCivilIdEstadoCivil.toJson(),
        "sexo_idSexo": sexoIdSexo.toJson(),
        "ocupacion_idOcupacion": ocupacionIdOcupacion.toJson(),
        "Tipodomicilio_idTipoDomicilio": tipodomicilioIdTipoDomicilio.toJson(),
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

class Documento {
    String idDocumento;
    String path;

    Documento({
        required this.idDocumento,
        required this.path,
    });

    factory Documento.fromJson(Map<String, dynamic> json) => Documento(
        idDocumento: json["idDocumento"],
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "idDocumento": idDocumento,
        "path": path,
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

class Horariocontacto {
    String idhorarioContacto;
    String especificacion;

    Horariocontacto({
        required this.idhorarioContacto,
        required this.especificacion,
    });

    factory Horariocontacto.fromJson(Map<String, dynamic> json) => Horariocontacto(
        idhorarioContacto: json["idhorarioContacto"],
        especificacion: json["especificacion"],
    );

    Map<String, dynamic> toJson() => {
        "idhorarioContacto": idhorarioContacto,
        "especificacion": especificacion,
    };
}

class MascotaPrevia {
    String idMascota;
    String path;

    MascotaPrevia({
        required this.idMascota,
        required this.path,
    });

    factory MascotaPrevia.fromJson(Map<String, dynamic> json) => MascotaPrevia(
        idMascota: json["idMascota"],
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "idMascota": idMascota,
        "path": path,
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

class UbicacionRequestPet {
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

    UbicacionRequestPet({
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

    factory UbicacionRequestPet.fromJson(Map<String, dynamic> json) => UbicacionRequestPet(
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
