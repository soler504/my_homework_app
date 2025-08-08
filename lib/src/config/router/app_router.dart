import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/pages/agg_asignatura_page.dart';
import 'package:my_homework_app/src/pages/bienvenida_page.dart';
import 'package:my_homework_app/src/pages/calendar_page.dart';
import 'package:my_homework_app/src/pages/home_page.dart';
import 'package:my_homework_app/src/pages/login_page.dart';
import 'package:my_homework_app/src/pages/new_tarea_page.dart';
import 'package:my_homework_app/src/pages/notificacion_page.dart';
import 'package:my_homework_app/src/pages/popups.dart'; 
import 'package:my_homework_app/src/pages/registro_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const BienvenidaPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/registro',
      builder: (context, state) => const RegistroPage(),
    ),
    GoRoute(
      path: '/popup',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const Popuppage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      name: 'agregar-asignatura',
      path: '/popup/agregar-asignatura',
      builder: (context, state) => const CrearAsignatura(),
    ),
    GoRoute(
      name: 'nueva-tarea',
      path: '/popup/nueva-tarea',
      builder: (context, state) => CrearTarea(asignaturas: []), 
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/notificacion',
      builder: (context, state) => const NotificacionPage(),
    ),
    GoRoute(
      path: '/calendar',
      builder: (context, state) => const CalendarPage(),
    ),
  ],
);