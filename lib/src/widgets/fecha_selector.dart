import 'package:flutter/material.dart';

class FechaSelector extends StatelessWidget {
  final String label;
  final DateTime? fecha;
  final void Function() onSeleccionar;

  const FechaSelector({
    super.key,
    required this.label,
    required this.fecha,
    required this.onSeleccionar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        const SizedBox(width: 10),
        Text(
          fecha == null
              ? 'No seleccionada'
              : '${fecha!.day}/${fecha!.month}/${fecha!.year}',
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: onSeleccionar,
          child: const Text('Seleccionar'),
        ),
      ],
    );
  }
}