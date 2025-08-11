
import '../model/asignatura_model.dart' show Asignatura;

class AsignaturasProvider {

  List<Asignatura> asignaturas = [];
  // Método para agregar una asignatura 
  void agregarAsignatura(Asignatura asignatura) {
    asignaturas.add(asignatura);
  }

  void actualizarAsignatura(int index, Asignatura asignaturaActualizada) {
    if (index >= 0 && index < asignaturas.length) {
      asignaturas[index] = asignaturaActualizada;
    }
  }

  void eliminarAsignatura(int index) {
    if (index >= 0 && index < asignaturas.length) {
      asignaturas.removeAt(index);
    }
  }
  
  Asignatura obtenerAsignaturaPorId(String id) {
    return asignaturas.firstWhere((asignatura) => asignatura.id == id, orElse: () => throw Exception('Asignatura no encontrada'));
  }

  Asignatura obtenerAsignaturaPorNombre(String nombre) {
    return asignaturas.firstWhere((asignatura) => asignatura.nombre == nombre, orElse: () => throw Exception('Asignatura no encontrada'));
  }
  // Método para obtener todas las asignaturas
  List<Asignatura> obtenerAsignaturas() {
    return asignaturas;
  }

}