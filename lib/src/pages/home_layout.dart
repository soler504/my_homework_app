import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/pages/calendar_page.dart';
import 'package:my_homework_app/src/pages/home_page.dart';
import 'package:my_homework_app/src/pages/perfil_page.dart';
import 'package:my_homework_app/src/widgets/custom_app_bar.dart';
import 'package:my_homework_app/src/widgets/custom_bottom_navigation.dart';
import 'package:my_homework_app/src/widgets/side_menu.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});
  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    final argumentos = GoRouter.of(context).routerDelegate.currentConfiguration.extra as Map<String, dynamic>?;
    final user = argumentos?['user'];
    final page = argumentos?['page'] ?? 'home';
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: CustomBottomNavigation(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(userURL: user?.photoURL ?? ''),
          ),
        drawer: SideMenu(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildHomePage(context),
          ),
        ),
      ),
    );
  }

  Widget buildHomePage(BuildContext context) {
    final argumentos = GoRouter.of(context).routerDelegate.currentConfiguration.extra as Map<String, dynamic>?;
    
    final page = argumentos?['page'];
    if (page == 'home') {
      return HomePage();
    } else if (page == 'calendar') {
      return CalendarPage();
    } else if (page == 'perfil') {
      return PerfilPage();
    }    
    else{
      return HomePage(); // Default to HomePage if no page is specified
    }
  }
}