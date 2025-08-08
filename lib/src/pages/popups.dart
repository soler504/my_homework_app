import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Popuppage extends StatelessWidget {
  const Popuppage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AlertDialog(
          title: const Text("¿Qué deseas crear?"),
          content: const Text("Selecciona una de las siguientes opciones:"),
          actions: [
            TextButton(
              onPressed: () {
                context.pop(); // Cierra el popup
                context.goNamed('nueva-tarea'); 
              },
              child: const Text("Nueva Tarea"),
            ),
            TextButton(
              onPressed: () {
                context.pop();
                context.goNamed('agregar-asignatura'); 
              },
              child: const Text("Nueva Asignatura"),
            ),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("Cancelar"),
            ),
          ],
        ),
      ),
    );
  }

  // Método estático para mostrar como diálogo 
  static void mostrar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Popuppage(),
    );
  }
}