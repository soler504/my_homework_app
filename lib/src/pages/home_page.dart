import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_homework_app/src/controller/tareas_controller.dart';import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_homework_app/src/widgets/card_dashboard.dart';
import 'package:my_homework_app/src/widgets/card_notificacion.dart';
import 'package:my_homework_app/src/widgets/task.dart';

import '../controller/tareas_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser;
  final TareasController controller = Get.find<TareasController>();
  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      DateTime today = DateTime(now.year, now.month, now.day);
      controller.obtenerTareasPorFecha(today);

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Bienvenido ${user?.displayName ?? user!.email}!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),

              controller.tareas.isEmpty
                  ? CardNotification(
                      texto1: 'No tienes tareas creadas.',
                      texto2: 'Click para crear una nueva tarea',
                    )
                  : Column(
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dashboard',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Mes ${DateFormat.MMMM('es').format(now)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CardDashboard(
                              width: 160,
                              height: 100,
                              iconSize: 35,
                              iconData: Icons.alarm_off_rounded,
                              iconColor: Colors.red,
                              texto1: '${controller.tareasFueraFecha.value}',
                              texto2: 'Fuera de fecha',
                            ),
                            CardDashboard(
                              width: 160,
                              height: 100,
                              iconSize: 35,
                              iconData: Icons.flag_circle,
                              iconColor: Colors.orange,
                              texto1: '${controller.tareasPendientes.value}',
                              texto2: 'Pendientes',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CardDashboard(
                              width: 160,
                              height: 100,
                              iconSize: 35,
                              iconData: Icons.check,
                              iconColor: Colors.green,
                              texto1: '${controller.tareasCompletadas.value}',
                              texto2: 'Tareas finalizadas',
                            ),
                            CardDashboard(
                              width: 160,
                              height: 100,
                              iconSize: 35,
                              iconData: Icons.calendar_month,
                              iconColor: Colors.purple,
                              texto1: '${controller.proximasTareas.value}',
                              texto2: 'Próximas tareas',
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Tareas del día',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 10),
                        controller.tareasFiltradas.isEmpty
                            ? CardNotification(
                                texto1: 'No tienes tareas para el día de hoy.',
                                texto2: 'Click para crear una nueva tarea',
                              )
                            : ListView.builder(
                                itemCount: controller.tareasFiltradas.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  final tarea =
                                      controller.tareasFiltradas[index];

                                  return Task(
                                    titulo: tarea.titulo,
                                    asignatura: tarea.asignatura.nombre,
                                    fecha: tarea.fechaLimite,
                                    iconData: tarea.completada
                                        ? Icons.check
                                        : Icons.cancel_outlined,
                                    color: tarea.completada
                                        ? Colors.green
                                        : Colors.red,
                                    id: tarea.id,
                                  );
                                },
                              ),
                      ],
                    ),
            ],
          ),
        ),
      );
    });
  }
}
