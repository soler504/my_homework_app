import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final argumentos =
        GoRouter.of(context).routerDelegate.currentConfiguration.extra
            as Map<String, dynamic>?;
    final user = argumentos?['user'];
    int selectedIndex = 0;
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: ''),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          label: '',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: (value) {
        setState(() {
          selectedIndex = value;
          if (selectedIndex == 0) {
            context.go('/home_layout', 
            extra: {'user': user, 'page': 'home'});
            return;
          }
          if (selectedIndex == 1) {
            // context.go('/home_layout', extra: {'page': 'perfil'});
            //aqui la logica para agregar una tarea
            context.push('/Popup');
            return;
          }
          if (selectedIndex == 2) {
            context.go(
              '/home_layout',
              extra: {'user': user, 'page': 'calendar'},
            );
            return;
          }

          
        });
      },
    );
  }
}
