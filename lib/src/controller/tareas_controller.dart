import 'package:get/get.dart';
import 'package:my_homework_app/src/model/tarea_model.dart';

class TareasController extends GetxController {
  var tareas = <Tarea>[].obs;

  RxInt tareasFueraFecha = 0.obs;
  RxInt tareasPendientes = 0.obs;
  RxInt tareasCompletadas = 0.obs;
  RxInt proximasTareas = 0.obs;
  RxList tareasHoy = [].obs;

  @override
  void onInit() {
    super.onInit();

    ever(tareas, (_) => _actualizarContadores());
    ever(tareas, (_) => _obtenerTareasDeHoy());
  }

  void _actualizarContadores() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    tareasFueraFecha.value = tareas
        .where(
          (t) =>
              t.isOverdue &&
              t.fechaLimite.year == today.year &&
              t.fechaLimite.month == today.month,
        )
        .length;

    tareasPendientes.value = tareas
        .where(
          (t) =>
              !t.completada &&
              t.fechaLimite.year == today.year &&
              t.fechaLimite.month == today.month,
        )
        .length;

    tareasCompletadas.value = tareas
        .where(
          (t) =>
              t.completada &&
              t.fechaLimite.year == today.year &&
              t.fechaLimite.month == today.month,
        )
        .length;

    proximasTareas.value = tareas
        .where((t) => t.fechaLimite.isAfter(DateTime.now()))
        .length;
  }

  void _obtenerTareasDeHoy() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    tareasHoy.value = tareas
        .where(
          (x) =>
              x.fechaLimite.year == today.year &&
              x.fechaLimite.month == today.month &&
              x.fechaLimite.day == today.day,
        )
        .toList();
  }

  void agregarTarea(Tarea tarea) {
    tareas.add(tarea);
  }

  void eliminarTarea(int index) {
    tareas.removeAt(index);
  }

  void actualizarTarea(int index, Tarea tarea) {
    tareas[index] = tarea;
  }

  void cambiarEstadoTarea(int index) {
    if (index >= 0 && index < tareas.length) {
      tareas[index].completada = !tareas[index].completada;
      tareas[index] = tareas[index];
    }
  }
}
