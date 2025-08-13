import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_homework_app/src/controller/tareas_controller.dart';
import 'package:my_homework_app/src/pages/ver_tareas_page.dart';
import 'package:my_homework_app/src/widgets/task.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({super.key});
  final TareasController controller = Get.find<TareasController>();

  @override
  Widget build(BuildContext context) {
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
                  controller.setFechaSeleccionada(details.date!);
                }
              },
            ),
            SizedBox(height: 10),
            controller.tareasFiltradas.isEmpty
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
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.tareasFiltradas.length,
                    itemBuilder: (context, index) {
                      final tarea = controller.tareasFiltradas[index];
                    return Task(
                      titulo: tarea.titulo,
                      asignatura: tarea.asignatura.nombre,
                      fecha: tarea.fechaLimite,
                      iconData: tarea.completada ? Icons.check : Icons.cancel_outlined,
                      color: tarea.completada ? Colors.green : Colors.red,
                      id: tarea.id,
                       onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => DetalleTareaVista(tarea: tarea),
                            ) ,
                          );
                        },
                      );
                    }
              ),
          ],
        ),
      );
    });
  }
}
