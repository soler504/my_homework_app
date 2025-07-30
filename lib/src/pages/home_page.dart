import 'package:flutter/material.dart';
import 'package:my_homework_app/src/widgets/custom_bottom_navigation.dart';
import 'package:my_homework_app/src/widgets/side_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
