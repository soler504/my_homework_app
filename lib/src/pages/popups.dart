import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class mostrarPopup {mostrarPopup(BuildContext context);
  static void mostrar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("¿Qué deseas crear?"),
        content: const Text("Selecciona una de las siguientes opciones:"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/nueva-tarea'); 
            },
            child: const Text("Nueva Tarea"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
              context.go('/nueva-asignatura'); 
            },
            child: const Text("Nueva Asignatura"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
        ],
      ),    
    );
  }
}