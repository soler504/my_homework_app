import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotification() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/icon_notification');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (_) {},
  );

  // Create channel
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_channel_id',
    'My Channel',
    description: 'Channel for important notifications',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);
}

Future<void> showNotification(String titulo, String mensaje) async {
  try {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'your_channel_id',
          'my channel',
          channelDescription: 'your_channel_description',
          priority: Priority.high,
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      1,
      titulo,
      mensaje,
      notificationDetails,
    );
  } catch (e) {
    SnackBar(
      backgroundColor: Colors.red,
      content: Text('Ocurrión un error', style: TextStyle(color: Colors.white)),
    );
  }
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
