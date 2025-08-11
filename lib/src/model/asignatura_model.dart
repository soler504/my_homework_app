import 'dart:ui' show Color;

class Asignatura{
  String id;
  String nombre;
  Color color;
  String descripcion;

  Asignatura({
    required this.id,
    required this.nombre,
    required this.color,
    this.descripcion = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }

  factory Asignatura.fromMap(Map<String, dynamic> map) {
    return Asignatura(
      id: map['id'],
      color: Color(map['color']),
      nombre: map['nombre'],
      descripcion: map['descripcion'],
    );
  }
}