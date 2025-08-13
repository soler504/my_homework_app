import 'package:my_homework_app/src/model/tarea_model.dart';

class TareasProvider {
  // Lista de tareas
  List<Tarea> tareas = [];

  // Método para agregar una tarea
  void agregarTarea(Tarea tarea) {
    tareas.add(tarea);
  }

  // Método para obtener todas las tareas
  List<Tarea> obtenerTareas() {
    return tareas;
  }

  void actualizarTarea(int index, Tarea tareaActualizada) {
    if (index >= 0 && index < tareas.length) {
      tareas[index] = tareaActualizada;
    }
  }
  // Método para marcar una tarea como completada
  void completarTarea(int index) {
    if (index >= 0 && index < tareas.length) {
      tareas[index].completada = true;
    }
  }
  // Método para eliminar una tarea
  void eliminarTarea(int index) {
    if (index >= 0 && index < tareas.length) {
      tareas.removeAt(index);
    }
  }
  List<Tarea> obtenerTareasCompletadas() {
    return tareas.where((tarea) => tarea.completada).toList();
  }
  List<Tarea> obtenerTareasPendientes() {
    return tareas.where((tarea) => !tarea.completada).toList();
  }
  List<Tarea> obtenerTareasVencidas() {
    return tareas.where((tarea) => tarea.isOverdue).toList();
  }
  List<Tarea> obtenerTareasPorAsignatura(String asignaturaId) {
    return tareas.where((tarea) => tarea.asignatura.id == asignaturaId).toList();
  }
  List<Tarea> obtenerTareasPorFecha(DateTime fecha) {
    return tareas.where((tarea) => tarea.isSameDay(fecha)).toList();
  }
}

