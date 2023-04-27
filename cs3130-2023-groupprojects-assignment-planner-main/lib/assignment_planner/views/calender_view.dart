import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'login_view.dart';

class Calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
              height: 680,
              child: SfCalendar(
                view: CalendarView.month,
                allowedViews: [
                  CalendarView.day,
                  CalendarView.week,
                  CalendarView.month
                ],
                todayHighlightColor: Colors.purple,
                dataSource: MeetingDataSource(_getDataSource()),
                monthViewSettings: MonthViewSettings(
                    navigationDirection: MonthNavigationDirection.vertical,
                    showAgenda: true,
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                    agendaViewHeight: 300),
                selectionDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.purple, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  shape: BoxShape.rectangle,
                ),
              )),
        ],
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];

    //final DateTime startTime =DateTime(today.year, today.month, today.day, 9, 0, 0);

    for (var coursename in user.userInfo.courseList!) {
      for (var assignment in coursename.assignmentList!) {
        var duedateStartTime =
            DateTime.parse(assignment.assignmentDueDateStartTime);
        var duedateEndTime =
            DateTime.parse(assignment.assignmentDueDateEndTime);
        final DateTime startTime = DateTime(
            duedateStartTime.year,
            duedateStartTime.month,
            duedateStartTime.day,
            duedateStartTime.hour,
            duedateStartTime.minute,
            duedateStartTime.second);
        final DateTime endTime = DateTime(
            duedateEndTime.year,
            duedateEndTime.month,
            duedateEndTime.day,
            duedateEndTime.hour,
            duedateEndTime.minute,
            duedateEndTime.second);

        meetings.add(Meeting(
            assignment.assignmentName + "," + coursename.courseName,
            startTime,
            endTime,
            Color.fromARGB(255, 110, 15, 134),
            false));
      }
    }

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
