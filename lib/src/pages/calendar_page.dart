import 'package:flutter/material.dart';
import 'package:my_homework_app/src/widgets/custom_bottom_navigation.dart';
import 'package:my_homework_app/src/widgets/side_menu.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigation(),
        appBar: AppBar(title: Text('My Homework')),
        drawer: SideMenu(),
      ),
    );
  }
}

