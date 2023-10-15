class Referencia {
    String idReferencia;
    String nombre;
    String apellidoPaterno;
    String apellidoMaterno;
    String telefono;
    int active;
    ParentescoIdParentesco parentescoIdParentesco;

    Referencia({
        required this.idReferencia,
        required this.nombre,
        required this.apellidoPaterno,
        required this.apellidoMaterno,
        required this.telefono,
        required this.active,
        required this.parentescoIdParentesco,
    });

    factory Referencia.fromJson(Map<String, dynamic> json) => Referencia(
        idReferencia: json["idReferencia"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        telefono: json["telefono"],
        active: json["active"],
        parentescoIdParentesco: ParentescoIdParentesco.fromJson(json["parentesco_idParentesco"]),
    );

    Map<String, dynamic> toJson() => {
        "idReferencia": idReferencia,
        "nombre": nombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "telefono": telefono,
        "active": active,
        "parentesco_idParentesco": parentescoIdParentesco.toJson(),
    };
}

class ParentescoIdParentesco {
    int idparentesco;
    String parentesco;

    ParentescoIdParentesco({
        required this.idparentesco,
        required this.parentesco,
    });

    factory ParentescoIdParentesco.fromJson(Map<String, dynamic> json) => ParentescoIdParentesco(
        idparentesco: json["idparentesco"],
        parentesco: json["parentesco"],
    );

    Map<String, dynamic> toJson() => {
        "idparentesco": idparentesco,
        "parentesco": parentesco,
    };
}