import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_homework_app/src/model/tarea_model.dart';
import 'package:my_homework_app/src/services/storage_service.dart';


class TareasProvider {
  // Lista de tareas
  List<Tarea> tareas = [];
  final FirestoreService _firestoreService = FirestoreService();
  final user = FirebaseAuth.instance.currentUser;
 
  
  Future<List<Tarea>> cargarTareas() async{
    tareas = await _firestoreService.obtenerTareas(user!.uid);
    return tareas ;
  } 

  // Método para agregar una tarea
  void agregarTarea(Tarea tarea) {
    _firestoreService.agregarTarea(user!.uid, tarea);
    tareas.add(tarea);
  }

  // Método para obtener todas las tareas
    void actualizarTarea(int index, Tarea tareaActualizada) {
    if (index >= 0 && index < tareas.length) {
      _firestoreService.actualizarTarea(user!.uid, tareaActualizada);
      tareas[index] = tareaActualizada;
    }
  }

  // Método para marcar una tarea como completada
  void completarTarea(int index) {
    if (index >= 0 && index < tareas.length) {
      tareas[index].completada = true;
      _firestoreService.actualizarTarea(user!.uid, tareas[index]);
    }
  }

  // Método para eliminar una tarea
  void eliminarTarea(int index) {

    if (index >= 0 && index < tareas.length) {
      _firestoreService.eliminarTarea(user!.uid, tareas[index].id);
      tareas.removeAt(index);
    }
  }
}
