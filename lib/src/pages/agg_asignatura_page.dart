import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:my_homework_app/src/controller/asignaturas_controller.dart';
import 'package:my_homework_app/src/model/asignatura_model.dart';


class CrearAsignatura extends StatefulWidget {
  

  const CrearAsignatura({super.key});

  @override
  State<CrearAsignatura> createState() => _CrearAsignaturaPopupState();
}

class _CrearAsignaturaPopupState extends State<CrearAsignatura> {
  final AsignaturasController asignaturasController = Get.put(AsignaturasController());
  final TextEditingController nombreController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  String? colorSeleccionado;

  final Map<String, Color> colores = {
    'Verde': Colors.green,
    'Rojo': Colors.red,
    'Azul': Colors.blue,
    'Morado': Colors.purple,
    'Amarillo': Colors.yellow,
    'Negro': Colors.black,
    'Cafe': Color.fromARGB(233, 124, 54, 30),
    'Gris': Color.fromARGB(255, 112, 111, 110),

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

    asignaturasController.agregarAsignatura(user!.uid,nuevaAsignatura);

    Navigator.pop(context);
    
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
            const SizedBox(height: 20),
            TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            onPressed: crearAsignatura,
            child: const Text('Crear asignatura'),
          ),
          ],
        ),
    );
  }
}
