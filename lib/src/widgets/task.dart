import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  final String titulo;
  final String asignatura;
  final DateTime fecha;
  final IconData iconData;
  final Color color;

  const Task({
    super.key,
    required this.titulo,
    required this.asignatura,
    required this.fecha,
    required this.iconData,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.task,
            size: 35,
            color: const Color.fromARGB(255, 8, 45, 75),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo),
              Text(asignatura),
              Text('${fecha.day}-${fecha.month}-${fecha.year}'),
            ],
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  title: const Text("¿Deseas cambiar el estado de la tarea?"),
                  actions: [
                    TextButton(onPressed: () {}, child: Text('Si')),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('No'),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(iconData, size: 35, color: color),
          ),
        ],
      ),
    );
  }
}
