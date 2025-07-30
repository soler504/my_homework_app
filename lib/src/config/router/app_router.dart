import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/pages/calendar_page.dart';
import 'package:my_homework_app/src/pages/home_page.dart';
import 'package:my_homework_app/src/pages/notificacion_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomePage()),
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(
      path: '/notificacion',
      builder: (context, state) => NotificacionPage(),
    ),
    GoRoute(path: '/calendar', builder: (context, state) => CalendarPage()),
  ],
);
