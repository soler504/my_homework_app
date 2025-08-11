import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:my_homework_app/src/services/auth_service.dart';
import 'package:my_homework_app/src/widgets/custom_app_bar.dart';
import 'package:my_homework_app/src/widgets/custom_bottom_navigation.dart';
import 'package:my_homework_app/src/widgets/card_dashboard.dart';
import 'package:my_homework_app/src/widgets/side_menu.dart';
// import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    
    final argumentos = GoRouter.of(context).routerDelegate.currentConfiguration.extra as Map<String, dynamic>?;
    final user = argumentos?['user'];
    
    print('user: ${user.displayName}');
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: CustomBottomNavigation(user: argumentos?['user']),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(userURL: user.photoURL),
          ),
        drawer: SideMenu(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Bienvenido tacuazin!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Card(
                  shadowColor: Colors.black,
                  elevation: 5,
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'No tienes tareas creadas.',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                'Click para crear una nueva tarea',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_task_outlined,
                              color: Colors.green,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Mes Agosto',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Divider(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardDashboard(
                      width: 160,
                      height: 100,
                      iconSize: 35,
                      iconData: Icons.alarm_off_rounded,
                      iconColor: Colors.red,
                      texto1: '25',
                      texto2: 'Fuera de fecha',
                    ),
                    CardDashboard(
                      width: 160,
                      height: 100,
                      iconSize: 35,
                      iconData: Icons.flag_circle,
                      iconColor: Colors.orange,
                      texto1: '25',
                      texto2: 'Por vencer',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardDashboard(
                      width: 160,
                      height: 100,
                      iconSize: 35,
                      iconData: Icons.check,
                      iconColor: Colors.green,
                      texto1: '25',
                      texto2: 'Tareas finalizadas',
                    ),
                    CardDashboard(
                      width: 160,
                      height: 100,
                      iconSize: 35,
                      iconData: Icons.calendar_month,
                      iconColor: Colors.purple,
                      texto1: '25',
                      texto2: 'Próximas tareas',
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Tareas del día',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Divider(height: 10),
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.task,
                        size: 35,
                        color: const Color.fromARGB(255, 8, 45, 75),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Titulo'),
                          Text('Asignatura'),
                          Text('Fecha creación'),
                        ],
                      ),
                      Icon(Icons.check, size: 35, color: Colors.green),
                    ],
                  ),
                ),
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.task,
                        size: 35,
                        color: const Color.fromARGB(255, 8, 45, 75),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Titulo'),
                          Text('Asignatura'),
                          Text('Fecha creación'),
                        ],
                      ),
                      Icon(Icons.cancel_outlined, size: 35, color: Colors.red),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Hay 10 tareas más',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
