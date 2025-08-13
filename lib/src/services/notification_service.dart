import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:my_homework_app/src/model/tarea_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //INITIALZE
  Future<void> initNotification() async {
    //init timezone handling
    tz.initializeTimeZones();
    final String currentTimeZone = DateTime.now().timeZoneName;
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    //android settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/icon_notification');

    //iOS settings
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    //init settings
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    //initialize the plugin
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //notification detail setup
  NotificationDetails notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_notification_id',
        'Notifications',
        channelDescription: 'Notifications',
        priority: Priority.high,
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  //show notification
  Future<void> showNotification(String titulo, String mensaje) async {
    await flutterLocalNotificationsPlugin.show(
      1,
      titulo,
      mensaje,
      notificationDetails(),
    );
  }

  Future<bool> checkPermission(BuildContext context) async {
    PermissionStatus status = await Permission.notification.status;

    if (status == PermissionStatus.permanentlyDenied) {
      showPermissionMessage(context);
      return false;
    }

    if (!status.isGranted) {
      status = await Permission.notification.request();
    }

    return status.isGranted;
  }

  void showPermissionMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('The permission is permanently denied'),
          content: Text(
            'You can only grant permission in the phone\'s application settings.',
          ),
        );
      },
    );
  }

  Future<void> scheduleAllTaskNotifications(
    List<Tarea> tasks,
    int reminderHours,
  ) async {
    if (tasks.isEmpty) {
      return;
    }

    for (var task in tasks) {
      final scheduledTime = task.fechaLimite.subtract(
        Duration(hours: reminderHours),
      );

      DateTime now = DateTime.now();
      DateTime hoy = DateTime(now.year, now.month, now.day);
      bool sePuedeEnviar =
          scheduledTime.isAtSameMomentAs(hoy) || scheduledTime.isAfter(hoy);

      if (sePuedeEnviar) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
          task.id.hashCode,
          'Recordatorio',
          'Tu tarea "${task.titulo}" está a punto de vencer!',
          tz.TZDateTime.from(scheduledTime, tz.local),
          notificationDetails(),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        );
      }
    }
  }
}
