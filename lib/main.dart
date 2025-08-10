import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_homework_app/src/config/router/app_router.dart';
import 'package:my_homework_app/src/config/theme/app_theme.dart';
import 'package:my_homework_app/src/controller/theme_controller.dart';
import 'package:my_homework_app/src/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
      );
    });
  }
}
