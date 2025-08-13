import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/controller/asignaturas_controller.dart';
import 'package:my_homework_app/src/controller/tareas_controller.dart';
import 'package:my_homework_app/src/model/tarea_model.dart';
import 'package:my_homework_app/src/pages/agg_asignatura_page.dart';
import 'package:my_homework_app/src/pages/calendar_page.dart';
import 'package:my_homework_app/src/pages/home_page.dart';
import 'package:my_homework_app/src/pages/new_tarea_page.dart';
import 'package:my_homework_app/src/pages/perfil_page.dart';
import 'package:my_homework_app/src/pages/ver_tareas_page.dart';
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
    Get.put(AsignaturasController());
    Get.put(TareasController());
    final User? user = FirebaseAuth.instance.currentUser;
    print('Usuario actual: ${user?.email ?? 'No hay usuario'}');
    
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
    } else if (page == 'ingresar_tarea') {
      return CrearTarea(); 
    } else if (page == 'ingresar_materia') {
      return CrearAsignatura(); 
   } else if (page =='ver_tareas'){
     return DetalleTareaVista(tarea: argumentos?['tarea'] as Tarea);
    }
  
    else{
      return HomePage(); 
    }
  }
}