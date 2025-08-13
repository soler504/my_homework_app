import 'package:get/get.dart';
import 'package:my_homework_app/src/model/tarea_model.dart';
import 'package:my_homework_app/src/services/Tareas_provider.dart';

import 'package:my_homework_app/src/services/notification_service.dart';

class TareasController extends GetxController {
  final _tareasProvider = TareasProvider();
  
  var tareas = <Tarea>[].obs;
  
  RxInt tareasFueraFecha = 0.obs;
  RxInt tareasPendientes = 0.obs;
  RxInt tareasCompletadas = 0.obs;
  RxInt proximasTareas = 0.obs;
  RxList tareasFiltradas = [].obs;
  var selectedDate = DateTime.now().obs;
  RxInt recordatorioHoras = 24.obs;
  RxBool sePuedeEnviarNofiticaciones = false.obs;
  RxInt selectedIndex = 3.obs;

  @override
  void onInit() async {
    super.onInit();
    tareas.value =  await _tareasProvider.cargarTareas();

    ever(tareas, (_) {
      _actualizarContadores();
      obtenerTareasPorFecha(selectedDate.value);
    });

    ever(selectedDate, (_) {
      obtenerTareasPorFecha(selectedDate.value);
    });

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    selectedDate.value = today;
    obtenerTareasPorFecha(today);
  }

  

  void _actualizarContadores() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    tareasFueraFecha.value = tareas
        .where(
          (t) =>
              t.isOverdue &&
              !t.completada &&
              t.fechaLimite.year == today.year &&
              t.fechaLimite.month == today.month,
        )
        .length;

    tareasPendientes.value = tareas
        .where(
          (t) =>
              !t.isOverdue &&
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

  void obtenerTareasPorFecha(DateTime fecha) {
    tareasFiltradas.value = tareas
        .where(
          (x) =>
              x.fechaLimite.year == fecha.year &&
              x.fechaLimite.month == fecha.month &&
              x.fechaLimite.day == fecha.day,
        )
        .toList();
  }

  Future<void> agregarTarea(Tarea tarea) async {
    _tareasProvider.agregarTarea(tarea);
    tareas.add(tarea);

    if (sePuedeEnviarNofiticaciones.value) {
      await NotificationService().scheduleAllTaskNotifications(
        tareas,
        recordatorioHoras.value,
      );
    }
  }

  void eliminarTarea(int index) {
    tareas.removeAt(index);
  }

  void actualizarTarea(int index, Tarea tarea) {
    tareas[index] = tarea;
  }

  void cambiarEstadoTarea(String id) {
    final index = tareas.indexWhere((t) => t.id == id);
    if (index != -1) {
      tareas[index].completada = !tareas[index].completada;
      tareas[index] = tareas[index];
    }
  }

  void setFechaSeleccionada(DateTime fecha) {
    selectedDate.value = fecha;
    obtenerTareasPorFecha(fecha);
  }
}
