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

import 'package:my_homework_app/src/pages/perfil_page.dart';
import 'package:my_homework_app/src/pages/registro_page.dart';

final appRouter = GoRouter(
  routes: [
    //paginas iniciales, bienvenida, login, registro
    GoRoute(path: '/', builder: (context, state) => BienvenidaPage()),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),

    GoRoute(path: '/Popup', 
    builder: (context, state) => mostrarPopup(context) as Widget),
        GoRoute(
                name: 'ingresar materia',
                path: '/Popup/nueva-asignatura',
                builder: (context, state) {
                  return CrearAsignatura();
                },
              ),
        GoRoute(
                name: 'ingresar materia',
                path: '/Popup/nueva-tarea',
                builder: (context, state) {
                  return CrearTarea(asignaturas: state.extra as List<String>);
                },
              ),
                    
    GoRoute(path: '/registro', builder: (context, state) => RegistroPage()),
    //paginas principales
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(path: '/notificacion', builder: (context, state) => NotificacionPage()),
    GoRoute(path: '/calendar', builder: (context, state) => CalendarPage()),
    GoRoute(path: '/perfil', builder: (context, state) => PerfilPage()),
  ],
);
