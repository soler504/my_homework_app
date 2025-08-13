import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
//import 'package:my_homework_app/src/controller/globales.dart';
import 'package:my_homework_app/src/controller/theme_controller.dart';

class SideMenu extends StatelessWidget {
  SideMenu({super.key});
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
  //final user = Get.find<Sesion>().usuarioActual;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'My Homework',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Text('Proyecto universitario de UNAH-VS'),
                Text('Versión 1.0.0'),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              context.push('/notificacion');
            },
            title: Text('Notificaciones'),
            leading: Icon(Icons.notifications),
          ),
           ListTile(
            onTap: () {
              context.push('/home_layout', extra: {'page': 'perfil'});
            },
            title: Text('Perfil'),
            leading: Icon(Icons.person),
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
