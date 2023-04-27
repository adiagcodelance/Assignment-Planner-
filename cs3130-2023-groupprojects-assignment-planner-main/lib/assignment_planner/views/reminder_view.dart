import 'package:flutter/material.dart';
import 'login_view.dart';

class Reminder extends StatefulWidget {
  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 600,
            child: ListView.separated(
              shrinkWrap: true,
              //controller: _controller,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: getReminder().length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    getReminder()[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Colors.black,
                height: 1.0,
                thickness: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> getReminder() {
    List<String> reminders = [];
    for (var course in user.userInfo.courseList!) {
      for (var assignment in course.assignmentList!) {
        int reminderDay = int.parse(assignment.assignmentTimeRemaining);
        print(reminderDay);
        if (reminderDay <= 86400) {
          String tempReminder =
              "${course.courseName} ${assignment.assignmentName} is due in ${assignment.assignmentDueDateEndTime}";
          reminders.add(tempReminder);
        }
      }
    }
    return reminders;
  }
}
