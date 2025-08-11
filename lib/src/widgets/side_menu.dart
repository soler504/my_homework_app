import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/controller/theme_controller.dart';

class SideMenu extends StatelessWidget {
  SideMenu({super.key});
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text('My Homework')),
          ListTile(
            onTap: () {
              context.push('/notificacion');
            },
            title: Text('Notificaciones'),
            leading: Icon(Icons.notifications),
          ),
          ListTile(
            title: Text('Claro/Oscuro'),
            leading: Obx(
              () => Switch(
                value: themeController.isDarkMode.value,
                onChanged: (value) {
                  themeController.toggleTheme();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
