import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //INITIALZE
  Future<void> initNotification() async {
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
}
