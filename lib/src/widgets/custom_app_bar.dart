import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.userURL});
  final String userURL;
  bool get existeURL => userURL != '';
  @override
  Widget build(BuildContext context) {

    return AppBar(
      title: Text('My Homework'),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: existeURL ? NetworkImage(userURL) : null,
            child: existeURL ? null : Icon(Icons.person)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // Or your custom height
}
