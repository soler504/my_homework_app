import 'package:flutter/material.dart';
import 'package:my_homework_app/src/services/notification_service.dart';
import 'package:my_homework_app/src/widgets/custom_elevatedbutton.dart';

class NotificacionPage extends StatefulWidget {
  const NotificacionPage({super.key});

  @override
  State<NotificacionPage> createState() => _NotificacionPageState();
}

class _NotificacionPageState extends State<NotificacionPage> {
  @override
  Widget build(BuildContext context) {
    bool? value = false;
    List<String> opciones = [
      '1 día antes',
      '2 días antes',
      '1 hora antes',
      'No recibir notificaciones',
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Recordatorio Notificaciones')),
          automaticallyImplyLeading: true,
        ),
        body: Column(
          children: [
            ...opciones.map(
              (opcion) => ListTile(
                title: Text(opcion),
                leading: Checkbox(
                  value: value,
                  onChanged: (bool? newValue) {
                    setState(() {
                      value = newValue;
                    });
                  },
                ),
              ),
            ),
            Boton(
              texto: 'Test',
              onpressed: () async {
                bool isGranted = await NotificationService().checkPermission(
                  context,
                );

                if (isGranted) {
                  await NotificationService().showNotification(
                    'titulo',
                    'descripcion',
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
