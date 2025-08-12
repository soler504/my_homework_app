import 'package:get/get.dart';
import 'package:my_homework_app/src/model/asignatura_model.dart';
import 'package:my_homework_app/src/services/Asignaturas_provider.dart';

class AsignaturasController extends GetxController {
  final AsignaturasProvider _asignaturasProvider = AsignaturasProvider();

  @override
  void onInit() {
    print('AsignaturaController inicializado');
    super.onInit();
  }

  void _agregarAsignatura(Asignatura asignatura) {
    _asignaturasProvider.agregarAsignatura(asignatura);
    update();
  }

  static void add(Asignatura asignatura) {
    final controller = Get.find<AsignaturasController>();
    controller._agregarAsignatura(asignatura);
  }

  List<Asignatura> _obtenerAsignaturas() {
    return _asignaturasProvider.obtenerAsignaturas();
  }

  static List<Asignatura> obtenerAsignaturas() {
    final controller = Get.find<AsignaturasController>();
    return controller._obtenerAsignaturas();
  }

  Asignatura _obtenerAsignaturasPorId(String id) {
    return _asignaturasProvider.obtenerAsignaturaPorId(id);
  }

  static Asignatura obtenerPorId(String id) {
    final controller = Get.find<AsignaturasController>();
    return controller._obtenerAsignaturasPorId(id);
  }

  void _eliminarAsignatura(int index) {
    _asignaturasProvider.eliminarAsignatura(index);
    update();
  }

  static void eliminar(int index) {
    final controller = Get.find<AsignaturasController>();
    controller._eliminarAsignatura(index);
  }

  void _actualizarAsignatura(int index, Asignatura asignatura) {
    _asignaturasProvider.actualizarAsignatura(index, asignatura);
    update();
  }

  static void actualizar(int index, Asignatura asignatura) {
    final controller = Get.find<AsignaturasController>();
    controller._actualizarAsignatura(index, asignatura);
  }

  Asignatura _obtenerAsignaturasPorNombre(String nombre) {
    return _asignaturasProvider.obtenerAsignaturaPorNombre(nombre);
  }

  static Asignatura obtenerPorNombre(String nombre) {
    final controller = Get.find<AsignaturasController>();
    return controller._obtenerAsignaturasPorNombre(nombre);
  }
}
