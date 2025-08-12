import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MostrarPopup {
  MostrarPopup(BuildContext context);
  static void mostrar(BuildContext context) {
    
    // print('desde el popup: ${user?.email}');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: const Text("¿Qué deseas crear?"),
        content: const Text("Selecciona una de las siguientes opciones:"),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(context);
              context.go(
                '/home_layout',
                extra: {'page': 'ingresar_tarea'},
              );
            },
            child: const Text("Nueva Tarea"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go(
                '/home_layout',
                extra: {'page': 'ingresar_materia'},
              );
              
            },
            child: const Text("Nueva Asignatura"),
          ),
          TextButton(
            onPressed: () => context.pop(context),
            child: const Text("Cancelar"),
          ),
        ],
      ),
    );
  }
}
