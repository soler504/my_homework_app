import 'package:get/get.dart';
import 'package:my_homework_app/src/model/tarea_model.dart';
import 'package:my_homework_app/src/services/Tareas_provider.dart';

class TareasController extends GetxController {
  final TareasProvider _tareasProvider = TareasProvider();
  @override
  void onInit() {
    print('TareasController inicializado');
    super.onInit();
  }

  void _agregarTarea(Tarea tarea) {
    _tareasProvider.agregarTarea(tarea);
    update();
  }

  List<Tarea> _obtenerTareas() {
    return _tareasProvider.obtenerTareas();
  }
  List<Tarea> _obtenerTareasPorAsignatura(String asignaturaId) {
    return _tareasProvider.obtenerTareasPorAsignatura(asignaturaId);
  }
  void _eliminarTarea(int index) {
    _tareasProvider.eliminarTarea(index);
    update();
  }
  void _actualizarTarea(int index,Tarea tarea) {
    _tareasProvider.actualizarTarea(index, tarea);
    update();
  }
  List<Tarea>? _obtenerTareasCompletadas() {
    return _tareasProvider.obtenerTareasCompletadas();
  }

  static void agregar(Tarea tarea) {
    final controller = Get.find<TareasController>();
    controller._agregarTarea(tarea);
  }

  static List<Tarea> obtenerTareas() {
    final controller = Get.find<TareasController>();
    return controller._obtenerTareas();
  }

  static List<Tarea> obtenerTareasPorAsignatura(String asignaturaId) {
    final controller = Get.find<TareasController>();
    return controller._obtenerTareasPorAsignatura(asignaturaId);
  }

  static void eliminar(int index) {
    final controller = Get.find<TareasController>();
    controller._eliminarTarea(index);
  }

  static void actualizar(int index, Tarea tarea) {
    final controller = Get.find<TareasController>();
    controller._actualizarTarea(index, tarea);
  }

  static List<Tarea>? obtenerTareasCompletadas() {
    final controller = Get.find<TareasController>();
    return controller._obtenerTareasCompletadas();
  }

}