import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/model/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  
  @override
  Widget build(BuildContext context) {
    // final argumentos = GoRouter.of(context).routerDelegate.currentConfiguration.extra as Map<String, dynamic>?;
    // final user = argumentos?['user'];
    // print('user: $user');
    return SfCalendar(
        view: CalendarView.month,
        firstDayOfWeek: 1,
        dataSource: MeetingDataSource(_getDataSource()),
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
  meetings.add(Meeting('Conference', startTime, endTime, const Color.fromARGB(255, 243, 33, 33), false));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }
}
