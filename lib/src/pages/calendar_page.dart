import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_homework_app/src/controller/asignaturas_controller.dart';
import 'package:my_homework_app/src/controller/tareas_controller.dart';
// import 'package:my_homework_app/src/services/storage_service.dart';
import 'package:my_homework_app/src/widgets/task.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({super.key});
  final  user = FirebaseAuth.instance.currentUser;
  // final FirestoreService _firestoreService = FirestoreService();
  final TareasController tareasController = Get.find<TareasController>();
  final AsignaturasController asignaturasController = Get.find<AsignaturasController>();
  String? asignaturaSeleccionada;

  @override
  Widget build(BuildContext context) {
    // final asignaturas =  asignaturasController.obtenerAsignaturas();
    return Obx(() {
      return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SfCalendar(
              view: CalendarView.month,
              firstDayOfWeek: 1,
              onTap: (CalendarTapDetails details) {
                if (details.date != null) {
                  tareasController.setFechaSeleccionada(details.date!);
                }
              },
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
              value: asignaturaSeleccionada ,
              hint: const Text('Selecciona una asignatura'),
              items: asignaturasController.asignaturas.map((asignatura) {
                return DropdownMenuItem<String>(
                  value: asignatura.id,
                  child: Text(asignatura.nombre),
                );
              }).toList(),
              onChanged: (value) {
                asignaturaSeleccionada = value;
              },
            ),
            SizedBox(height: 10),
            tareasController.tareasFiltradas.isEmpty
                ? Card(
                    shadowColor: Colors.black,
                    elevation: 5,
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'No tienes tareas asignadas para esta fecha',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: tareasController.tareasFiltradas.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final tarea = tareasController.tareasFiltradas[index];

                      return Task(
                        titulo: tarea.titulo,
                        asignatura: tarea.asignatura.nombre,
                        fecha: tarea.fechaLimite,
                        iconData: tarea.completada
                            ? Icons.check
                            : Icons.cancel_outlined,
                        color: tarea.completada ? Colors.green : Colors.red,
                        id: tarea.id,
                      );
                    },
                  ),
          ],
        ),
      );
    });
  }
}
