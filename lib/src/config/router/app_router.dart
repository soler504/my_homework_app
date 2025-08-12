import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/controller/globales.dart';
import 'package:my_homework_app/src/pages/agg_asignatura_page.dart';
import 'package:my_homework_app/src/pages/bienvenida_page.dart';
import 'package:my_homework_app/src/pages/calendar_page.dart';
import 'package:my_homework_app/src/pages/home_layout.dart';
import 'package:my_homework_app/src/pages/home_page.dart';
import 'package:my_homework_app/src/pages/login_page.dart';
import 'package:my_homework_app/src/pages/new_tarea_page.dart';
import 'package:my_homework_app/src/pages/notificacion_page.dart';
import 'package:my_homework_app/src/pages/popups.dart';

import 'package:my_homework_app/src/pages/perfil_page.dart';
import 'package:my_homework_app/src/pages/registro_page.dart';

final appRouter = GoRouter(
  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null && 
    !state.matchedLocation.startsWith('/login') &&
    !state.matchedLocation.startsWith('/registro') &&
    !state.matchedLocation.startsWith('/')) {
      return '/login';
    }
    if (user != null && 
        (state.matchedLocation == '/login' || 
         state.matchedLocation == '/register')) {
      Get.find<Sesion>().usuarioActual = user;
      return '/home_layout';
    }

    return null;

  },
  initialLocation: '/',
  routes: [
    //paginas iniciales, bienvenida, login, registro
    GoRoute(path: '/', builder: (context, state) => BienvenidaPage()),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),

    GoRoute(
      path: '/Popup',
      builder: (context, state) => mostrarPopup(context) as Widget,
    ),
    GoRoute(
      name: 'ingresar_materia',
      path: '/nueva-asignatura',
      builder: (context, state) {
        return CrearAsignatura();
      },
    ),
    GoRoute(
      name: 'ingresar_tarea',
      path: '/nueva-tarea',
      builder: (context, state) {
        return CrearTarea();
      },
    ),

    GoRoute(path: '/registro', builder: (context, state) => RegistroPage()),
    //paginas principales
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(path: '/home_layout', builder: (context, state) => Layout()),
    GoRoute(
      path: '/notificacion',
      builder: (context, state) => NotificacionPage(),
    ),
    GoRoute(path: '/calendar', builder: (context, state) => CalendarPage()),
    GoRoute(path: '/perfil', builder: (context, state) => PerfilPage()),
  ],
);
