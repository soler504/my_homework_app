
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_homework_app/src/services/storage_service.dart';

import '../model/asignatura_model.dart' show Asignatura;

class AsignaturasProvider {

  List<Asignatura> asignaturas = [];
  final FirestoreService _firestoreService = FirestoreService();
  

  Future<List<Asignatura>> cargarAsignaturas(String userId) async{
    asignaturas =  await _firestoreService.obtenerAsignaturas(userId);
    return asignaturas;
  }

  // Método para agregar una asignatura 
  void agregarAsignatura(String userId,Asignatura asignatura) {
    _firestoreService.agregarAsignatura(userId, asignatura);
    asignaturas.add(asignatura);
  }

  void actualizarAsignatura(int index,String userId, Asignatura asignaturaActualizada) {
    if (index >= 0 && index < asignaturas.length) {
      _firestoreService.actualizarAsignatura(userId, asignaturaActualizada);
      asignaturas[index] = asignaturaActualizada;
    }
  }

  void eliminarAsignatura(int index,String userId) {
    if (index >= 0 && index < asignaturas.length) {
      _firestoreService.eliminarAsignatura(userId, asignaturas[index].id);
      asignaturas.removeAt(index);
    }
  }
  
  Asignatura obtenerAsignaturaPorId(String id) {
    return asignaturas.firstWhere((asignatura) => asignatura.id == id, orElse: () => throw Exception('Asignatura no encontrada'));
  }

  Asignatura obtenerAsignaturaPorNombre(String nombre) {
    return asignaturas.firstWhere((asignatura) => asignatura.nombre == nombre, orElse: () => throw Exception('Asignatura no encontrada'));
  }

}