// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_homework_app/src/model/asignatura_model.dart';
import 'package:my_homework_app/src/services/asignaturas_provider.dart';

class AsignaturasController extends GetxController {
  
  final AsignaturasProvider _asignaturasProvider = AsignaturasProvider();

  final asignaturas =  <Asignatura>[].obs;
  final asignaturasFiltradas =  <Asignatura>[].obs;
  final asignaturaSeleccionada = ''.obs;

  @override
  void onInit() async {
    
   
    super.onInit();

    print('AsignaturaController inicializado');
  }
  Future<List<Asignatura>> obtenerAsignaturas(String userId) async {

    try {
      final asignaturasCargadas = await _asignaturasProvider.cargarAsignaturas(userId);
    asignaturas.value = asignaturasCargadas;
    print('Asignaturas de $userId cargadas correctamente desde obtenerAsignaturas. Length = ${asignaturasCargadas.length}');
    return asignaturas.value;
    } catch (e){
      return [];
    }
  }


  Future<void> agregarAsignatura(String userId,Asignatura asignatura) async {
    _asignaturasProvider.agregarAsignatura(userId,asignatura);
    asignaturas.value = await obtenerAsignaturas(userId);
    print('Asignatura de $userId cargadas correctamente desde agregarAsignaturas');
    update();
  }

  Asignatura obtenerAsignaturasPorId(String id) {
    return _asignaturasProvider.obtenerAsignaturaPorId(id);
  }

  Future<void> eliminarAsignatura(int index,String userId) async {
    _asignaturasProvider.eliminarAsignatura(index, userId);
    asignaturas.value = await obtenerAsignaturas(userId);
    print('Asignatura de $userId Eliminada correctamente');
    update();
  }

  Future<void> actualizarAsignatura(int index,String userId, Asignatura asignatura) async {
    _asignaturasProvider.actualizarAsignatura(index,userId, asignatura);
    asignaturas.value = await obtenerAsignaturas(userId);
    print('Asignatura de $userId actualizada correctamente');
    update();
  }

  Asignatura obtenerAsignaturasPorNombre(String nombre) {
    return _asignaturasProvider.obtenerAsignaturaPorNombre(nombre);
  }


}
