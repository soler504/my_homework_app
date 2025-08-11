import 'package:my_homework_app/src/model/asignatura_model.dart';

class Tarea{

  String id;
  String titulo;
  String descripcion;
  DateTime fechaInicio;
  DateTime fechaLimite;
  Asignatura asignatura;
  bool completada;
  bool get isOverdue => fechaLimite.isBefore(DateTime.now());

  Tarea({
    required this.id,
    required this.titulo,
    required this.asignatura,
    required this.descripcion,
    required this.fechaInicio,
    required this.fechaLimite,
    this.completada = false,
  });

  set completadaStatus(bool value) {
    completada = value;
  }
  // Método para convertir un objeto Tarea a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'asignaturaId': asignatura.id,
      'fechaInicio': fechaInicio.toIso8601String(),
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