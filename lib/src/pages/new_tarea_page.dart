import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/controller/asignaturas_controller.dart';
import 'package:my_homework_app/src/controller/globales.dart';
import 'package:my_homework_app/src/controller/tareas_controller.dart';
import 'package:my_homework_app/src/model/tarea_model.dart';
import 'package:my_homework_app/src/services/Tareas_provider.dart';
import 'package:my_homework_app/src/widgets/fecha_selector.dart';
import '../services/Asignaturas_provider.dart';

class CrearTarea extends StatefulWidget {
  const CrearTarea({super.key});

  @override
  State<CrearTarea> createState() => _CrearTareaPageState();
}

class _CrearTareaPageState extends State<CrearTarea> {
  final asignaturasProvider = AsignaturasProvider();

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

    if (titulo.isEmpty ||
        descripcion.isEmpty ||
        asignaturaSeleccionada == null ||
        fechaInicio == null ||
        fechaFin == null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Faltan campos'),
          content: const Text(
            'Completa todos los campos para guardar la tarea.',
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => context.pop(context),
            ),
          ],
        ),
      );
      return;
    }
    Tarea nuevaTarea = Tarea(
      titulo: tituloController.text,
      descripcion: descripcionController.text,
      asignatura: asignaturasProvider.obtenerAsignaturaPorId(
        asignaturaSeleccionada!,
      ),
      fechaInicio: fechaInicio ?? DateTime.now(),
      fechaLimite: fechaFin ?? DateTime.now().add(Duration(days: 7)),
      id: '${DateTime.now().millisecondsSinceEpoch}',
    );
    TareasController.agregar(nuevaTarea);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tarea guardada'),
        content: Text('La tarea "$titulo" ha sido guardada correctamente.'),
        actions: [
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asignaturas = AsignaturasController.obtenerAsignaturas();

    return Scaffold(
      appBar: AppBar(title: const Text('Crear Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text('Título:', style: TextStyle(fontSize: 16)),
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                hintText: 'Ej: Examen de Física',
              ),
            ),
            const SizedBox(height: 16),
            const Text('Descripción:', style: TextStyle(fontSize: 16)),
            TextField(
              controller: descripcionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Detalles de la tarea...',
              ),
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
            FechaSelector(
              label: 'Fecha inicio:',
              fecha: fechaInicio,
              onSeleccionar: () => seleccionarFechaInicio(context),
            ),
            const SizedBox(height: 10),
            FechaSelector(
              label: 'Fecha Fin:',
              fecha: fechaFin,
              onSeleccionar: () => seleccionarFechaFin(context),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: guardarTarea,
                child: const Text('Guardar Tarea'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
