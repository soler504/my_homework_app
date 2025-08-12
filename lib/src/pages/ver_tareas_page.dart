import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/model/tarea_model.dart';

// Un widget para mostrar los detalles de una tarea específica.
class DetalleTareaVista extends StatelessWidget {
  // La tarea que se va a mostrar. Se recibe a través del constructor.
  final Tarea tarea;

  const DetalleTareaVista({super.key, required this.tarea});

  @override
  Widget build(BuildContext context) {
        final argumentos =
        GoRouter.of(context).routerDelegate.currentConfiguration.extra
            as Map<String, dynamic>?;
    final user = argumentos?['ver tareas '];
    print('desde el popup: ${user?.email}');
    // Para formatear las fechas de manera legible (dd/mm/aaaa)
    final String fechaInicioFormateada = tarea.fechainicio != null
        ? '${tarea.fechainicio!.day}/${tarea.fechainicio!.month}/${tarea.fechainicio!.year}'
        : 'No definida';
        
    final String fechaFinFormateada =
        '${tarea.fechaLimite.day}/${tarea.fechaLimite.month}/${tarea.fechaLimite.year}';

    return Scaffold(
      appBar: AppBar(
        // El título de la barra superior será el título de la tarea.
        title: Text(tarea.titulo),
        backgroundColor: tarea.asignatura.color.withOpacity(0.2), // Un toque de color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // Sección del Título
            _buildTituloSeccion(),
            const SizedBox(height: 24),

            // Sección de Fechas
            _buildFechasSeccion(fechaInicioFormateada, fechaFinFormateada),
            const Divider(height: 32),

            // Sección de Descripción
            _buildDescripcionSeccion(),
            const Divider(height: 32),

            // Sección de Estado
            _buildEstadoSeccion(),
          ],
        ),
      ),
    );
  }

  // Widget para mostrar el título y la asignatura
  Widget _buildTituloSeccion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TAREA:',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          tarea.titulo,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Chip(
          label: Text(tarea.asignatura.nombre),
          backgroundColor: tarea.asignatura.color,
          labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          avatar: Icon(Icons.school, color: Colors.white.withOpacity(0.8)),
        ),
      ],
    );
  }

  // Widget para mostrar las fechas de inicio y fin
  Widget _buildFechasSeccion(String inicio, String fin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoColumna('Fecha de Inicio', inicio, Icons.calendar_today_outlined),
        _buildInfoColumna('Fecha Límite', fin, Icons.event_available_outlined),
      ],
    );
  }

  // Widget para mostrar la descripción
  Widget _buildDescripcionSeccion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descripción',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          tarea.descripcion,
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
      ],
    );
  }

  // Widget para mostrar el estado de la tarea (completada o pendiente)
  Widget _buildEstadoSeccion() {
    return Row(
      children: [
        const Text(
          'Estado: ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Icon(
          tarea.completada ? Icons.check_circle : Icons.radio_button_unchecked,
          color: tarea.completada ? Colors.green : Colors.orange,
        ),
        const SizedBox(width: 8),
        Text(
          tarea.completada ? 'Completada' : 'Pendiente',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: tarea.completada ? Colors.green : Colors.orange,
          ),
        ),
      ],
    );
  }
  
  // Helper para crear columnas de información reutilizables
  Widget _buildInfoColumna(String titulo, String valor, IconData icono) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo.toUpperCase(),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(icono, size: 18, color: Colors.grey[700]),
            const SizedBox(width: 8),
            Text(
              valor,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
    );
  }
}