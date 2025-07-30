import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text('My Homework')),
          ListTile(
            onTap: () {
              context.go('/notificacion');
            },
            title: Text('Notificaciones'),
            leading: Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }
}
