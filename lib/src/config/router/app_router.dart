import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/pages/bienvenida_page.dart';
import 'package:my_homework_app/src/pages/calendar_page.dart';
import 'package:my_homework_app/src/pages/home_page.dart';
import 'package:my_homework_app/src/pages/login_page.dart';
import 'package:my_homework_app/src/pages/notificacion_page.dart';
import 'package:my_homework_app/src/pages/registro_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => BienvenidaPage()),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(path: '/registro', builder: (context, state) => RegistroPage()),

    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(
      path: '/notificacion',
      builder: (context, state) => NotificacionPage(),
    ),
    GoRoute(path: '/calendar', builder: (context, state) => CalendarPage()),
  ],
);
