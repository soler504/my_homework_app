
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/model/meeting.dart';
import 'package:my_homework_app/src/widgets/task.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    print('user: $user');
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SfCalendar(
            view: CalendarView.month,
            firstDayOfWeek: 1,
            dataSource: MeetingDataSource(_getDataSource()),
          ),
          SizedBox(height: 10),
          DropdownMenu(
            enableSearch: true,
            expandedInsets: EdgeInsets.zero,
            dropdownMenuEntries: [],
          ),
          SizedBox(height: 10),
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
        ],
      ),
    );
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(
    today.year,
    today.month,
    today.day,
    9,
    0,
    0,
  );
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(
    Meeting(
      'Conference',
      startTime,
      endTime,
      const Color.fromARGB(255, 243, 33, 33),
      false,
    ),
  );
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }
}
