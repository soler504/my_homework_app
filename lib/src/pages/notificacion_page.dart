import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_homework_app/src/controller/tareas_controller.dart';
import 'package:my_homework_app/src/services/notification_service.dart';

class NotificacionPage extends StatelessWidget {
  NotificacionPage({super.key});
  final TareasController controller = Get.find<TareasController>();

  final List<String> opciones = [
    '1 día antes',
    '2 días antes',
    '3 días antes',
    'No recibir notificaciones',
  ];

  @override
  Widget build(BuildContext context) {
    controller.selectedIndex.value = controller.selectedIndex.value;

    return Obx(() {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Recordatorio Notificaciones')),
            automaticallyImplyLeading: true,
          ),
          body: Column(
            children: [
              ...List.generate(opciones.length, (index) {
                return ListTile(
                  title: Text(opciones[index]),
                  leading: Radio<int>(
                    value: index,
                    groupValue: controller.selectedIndex.value,
                    onChanged: (int? newValue) async {
                      controller.selectedIndex.value = newValue ?? 3;

                      controller.sePuedeEnviarNofiticaciones.value =
                          newValue != 3;

                      if (newValue == 0) {
                        controller.recordatorioHoras.value = 24;
                      }

                      if (newValue == 1) {
                        controller.recordatorioHoras.value = 48;
                      }

                      if (newValue == 2) {
                        controller.recordatorioHoras.value = 72;
                      }

                      if (newValue != 3) {
                        await NotificationService()
                            .scheduleAllTaskNotifications(
                              controller.tareas,
                              controller.recordatorioHoras.value,
                            );
                      }
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
