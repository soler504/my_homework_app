import 'package:my_homework_app/src/model/asignatura_model.dart';

class Tarea {
  String id;
  String titulo;
  String descripcion;
  DateTime fechaLimite;
  DateTime? fechaInicio;
  Asignatura asignatura;
  bool completada;
  bool get isOverdue {
    DateTime now = DateTime.now();
    DateTime hoy = DateTime(now.year, now.month, now.day);
    return fechaLimite.isBefore(hoy);
  }

  Tarea({
    required this.id,
    required this.titulo,
    required this.asignatura,
    required this.descripcion,
    required this.fechaLimite,
    required this.fechaInicio,
    this.completada = false,
  });

  factory Tarea.fromMap(Map<String, dynamic> map) {
    return Tarea(
      id: map['id'] ?? '',
      titulo: map['titulo'] ?? '',
      descripcion: map['descripcion'] ?? '',
      fechaLimite: DateTime.parse(map['fechaLimite']),
      fechaInicio: map['fechaInicio'] != null
          ? DateTime.parse(map['fechaInicio'])
          : null,
      asignatura: Asignatura.fromMap(map['asignatura']),
      completada: map['completada'] == 1, // Convertir int a bool
    );
  }

  // Método para convertir un objeto Tarea a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaLimite': fechaLimite.toIso8601String(),
      'completada': completada ? 1 : 0, // Convertir bool a int
    };
  }

  bool isSameDay(DateTime other) {
    return fechaLimite.year == other.year &&
        fechaLimite.month == other.month &&
        fechaLimite.day == other.day;
  }
}
