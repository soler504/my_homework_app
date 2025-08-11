import 'package:my_homework_app/src/model/asignatura_model.dart';

class AsignaturasProvider {

  List<Asignatura> asignaturas = [];
  // Método para agregar una asignatura 
  void agregarAsignatura(Asignatura asignatura) {
    asignaturas.add(asignatura);
  }
  // Método para obtener todas las asignaturas
  List<Asignatura> obtenerAsignaturas() {
    return asignaturas;
  }

}