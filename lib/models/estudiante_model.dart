// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);

import 'dart:convert';

Estudiante noteFromJson(String str) => Estudiante.fromJson(json.decode(str));

String noteToJson(Estudiante data) => json.encode(data.toJson());

class Estudiante {
  int? id;
  String nombre;
  String apellido;
  int edad;

  Estudiante({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.edad,
  });

  factory Estudiante.fromJson(Map<String, dynamic> json) => Estudiante(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        edad: json["edad"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "edad": edad,
      };
}
