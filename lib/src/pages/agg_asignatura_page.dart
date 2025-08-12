import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/controller/asignaturas_controller.dart';
import 'package:my_homework_app/src/model/asignatura_model.dart';


class CrearAsignatura extends StatefulWidget {
  

  const CrearAsignatura({super.key});

  @override
  State<CrearAsignatura> createState() => _CrearAsignaturaPopupState();
}

class _CrearAsignaturaPopupState extends State<CrearAsignatura> {
  
  final TextEditingController nombreController = TextEditingController();
  String? colorSeleccionado;

  final Map<String, Color> colores = {
    'Verde': Colors.green,
    'Rojo': Colors.red,
    'Azul': Colors.blue,
    'Morado': Colors.purple,
    'Amarillo': Colors.yellow,
    'Negro': Colors.black,
  };

  void crearAsignatura() {
    final nombre = nombreController.text;
    final color = colorSeleccionado != null ? colores[colorSeleccionado] : null;

    if (nombre.isEmpty || color == null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Campos incompletos'),
          content: const Text('Por favor completa todos los campos.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );

      return;
    }
    final nuevaAsignatura = Asignatura(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      nombre: nombreController.text,
      color: color,
    );

    AsignaturasController.add(nuevaAsignatura);

    
    context.go('/home_layout', extra:{'page':'home'});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nueva Asignatura'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nombre de la asignatura:',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(hintText: 'Ej: Matemáticas'),
            ),
            const SizedBox(height: 20),
            const Text('Color del texto:', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: colorSeleccionado,
              hint: const Text('Selecciona un color'),
              isExpanded: true,
              items: colores.keys.map((colorNombre) {
                return DropdownMenuItem<String>(
                  value: colorNombre,
                  child: Text(
                    colorNombre,
                    style: TextStyle(color: colores[colorNombre]),
                  ),
                );
              }).toList(),
              onChanged: (valor) {
                setState(() {
                  colorSeleccionado = valor;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          onPressed: crearAsignatura,
          child: const Text('Crear asignatura'),
        ),
      ],
    );
  }
}
