import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class mostrarPopup {
  mostrarPopup(BuildContext context);
  static void mostrar(BuildContext context) {
    final argumentos =
        GoRouter.of(context).routerDelegate.currentConfiguration.extra
            as Map<String, dynamic>?;
    final user = argumentos?['user'];
    print('desde el popup: ${user?.email}');
    // Mostrar el diálogo de selección
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: const Text("¿Qué deseas crear?"),
        content: const Text("Selecciona una de las siguientes opciones:"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go(
                '/home_layout',
                extra: {'user': user, 'page': 'ingresar_tarea'},
              );
            },
            child: const Text("Nueva Tarea"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go(
                '/home_layout',
                extra: {'user': user, 'page': 'ingresar_materia'},
              );
              
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
