import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_homework_app/src/widgets/card_dashboard.dart';
import 'package:my_homework_app/src/widgets/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    
    
    final user = FirebaseAuth.instance.currentUser;
    print('user: ${user!=null ? user.displayName : 'No hay usuario'}');
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Bienvenido ${user?.displayName ?? user!.email}!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  'Mes Agosto',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Divider(height: 10),
            Task(
              titulo: 'Titulo',
              asignatura: 'Asignatura',
              fecha: DateTime.now(),
              iconData: Icons.check,
              color: Colors.green,
            ),
            Task(
              titulo: 'Titulo',
              asignatura: 'Asignatura',
              fecha: DateTime.now(),
              iconData: Icons.cancel_outlined,
              color: Colors.red,
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
    );
  }
}
