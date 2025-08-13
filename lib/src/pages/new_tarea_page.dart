import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/controller/asignaturas_controller.dart';
import 'package:my_homework_app/src/controller/tareas_controller.dart';
import 'package:my_homework_app/src/model/tarea_model.dart';
import 'package:my_homework_app/src/pages/popups.dart';


class CrearTarea extends StatefulWidget {
  const CrearTarea({super.key});

  @override
  State<CrearTarea> createState() => _CrearTareaPageState();
}

class _CrearTareaPageState extends State<CrearTarea> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  String? asignaturaSeleccionada;
  DateTime? fechaInicio;
  DateTime? fechaFin;

  Future<void> seleccionarFechaInicio(BuildContext context) async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: fechaInicio ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (fecha != null) {
      setState(() => fechaInicio = fecha);
    }
  }

  Future<void> seleccionarFechaFin(BuildContext context) async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: fechaFin ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (fecha != null) {
      setState(() => fechaFin = fecha);
    }
  }

  void guardarTarea() {
    final titulo = tituloController.text;
    final descripcion = descripcionController.text;

    if (titulo.isEmpty || descripcion.isEmpty || asignaturaSeleccionada == null || fechaInicio == null || fechaFin == null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Faltan campos'),
          content: const Text('Completa todos los campos para guardar la tarea.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => context.pop(),
            ),
          ],
        ),
      );
      return;
    }
    Tarea nuevaTarea = Tarea(
      titulo: tituloController.text,
      descripcion: descripcionController.text,
      asignatura: AsignaturasController.obtenerPorId(
        asignaturaSeleccionada!,
      ),
      fechaInicio: fechaInicio ?? DateTime.now(),
      fechaLimite: fechaFin ?? DateTime.now().add(const Duration(days: 7)),
      id: '${DateTime.now().millisecondsSinceEpoch}',
    );
    TareasController.agregar(nuevaTarea);
    SnackBar snackBar = SnackBar(
      content: Text('Tarea "$titulo" guardada correctamente.'),
      duration: const Duration(seconds: 2),
    );
    
    // El doble pop podría ser para cerrar un modal y luego la pantalla de creación.
    // Esto es correcto si la pantalla se muestra sobre otra que también debe cerrarse.
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
    }
    

  @override
  Widget build(BuildContext context) {
    final asignaturas = AsignaturasController.obtenerAsignaturas();

    return Container(
      margin: const EdgeInsets.all(2),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Título:', style: TextStyle(fontSize: 16)),
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(hintText: 'Ej: Examen de Física'),
            ),
            const SizedBox(height: 16),
            const Text('Descripción:', style: TextStyle(fontSize: 16)),
            TextField(
              controller: descripcionController,
              maxLines: 3,
              decoration: const InputDecoration(hintText: 'Detalles de la tarea...'),
            ),
            const SizedBox(height: 16),
            const Text('Asignatura:', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              isExpanded: true,
              value: asignaturaSeleccionada,
              hint: const Text('Selecciona una asignatura'),
              items: asignaturas.map((asignatura) {
                return DropdownMenuItem<String>(
                  value: asignatura.id,
                  child: Text(asignatura.nombre),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => asignaturaSeleccionada = value);
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Fecha inicio:'),
                const SizedBox(width: 10),
                Text(
                  fechaInicio == null
                      ? 'No seleccionada'
                      : '${fechaInicio!.day}/${fechaInicio!.month}/${fechaInicio!.year}',
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => seleccionarFechaInicio(context),
                  child: const Text('Seleccionar', style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w100)
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Fecha fin:'),
                const SizedBox(width: 10),
                Text(
                  fechaFin == null
                      ? 'No seleccionada'
                      : '${fechaFin!.day}/${fechaFin!.month}/${fechaFin!.year}',
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => seleccionarFechaFin(context),
                  child: const Text('Seleccionar', style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w100)
                      ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
              children: [
                // Botón para cancelar y volver
                TextButton(
                  onPressed: () => context.pop(MostrarPopup(context)), 
                  child: const Text('Cancelar'),
                ),
                // Botón para guardar la tarea
                ElevatedButton(
                  onPressed: guardarTarea,
                  child: const Text('Guardar Tarea'),
                ),
              ],
            ),
           
          ],
        ),
      ),
    );
  }
}