import 'package:assignment_planner/assignment_planner/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../routes/route_generator.dart';
import 'login_view.dart';

class AssignemntForm extends StatefulWidget {
  @override
  State<AssignemntForm> createState() => AssignmentFormState();
}

class AssignmentFormState extends State<AssignemntForm> {
  final _courseName = SingleValueDropDownController();
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  final _assignmentName = TextEditingController();
  final _assignmentDueDateStartTime = TextEditingController();
  final _assignmentDueDateEndTime = TextEditingController();
  bool _validate = false;

  var courseNameG = "";

  @override
  void dispose() {
    _courseName.dispose();
    _assignmentName.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _assignmentDueDateStartTime.text = ""; //set the initial value of text field
    _assignmentDueDateEndTime.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(
          "UAP",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: newAssignmentForm(),
    );
  }

  Widget newAssignmentForm() {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          height: 50,
        ),
        Text(
          'New Assignment            ',
          style: TextStyle(fontSize: 35),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 20),
        Container(
          width: 390,
          padding: const EdgeInsets.all(10),
          child: DropDownTextField(
            controller: _courseName,
            textFieldDecoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.list_alt_outlined)),
            clearOption: false,
            textFieldFocusNode: textFieldFocusNode,
            searchFocusNode: searchFocusNode,
            dropDownItemCount: user.userInfo.courseList!.length,
            searchShowCursor: false,
            dropDownList: [
              DropDownValueModel(
                  name: user.userInfo.courseList![user.index].courseName,
                  value: user.userInfo.courseList![user.index].courseName)
            ],
            onChanged: (val) {
              courseNameG = user.userInfo.courseList![user.index].courseName;
            },
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: 390,
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _assignmentName,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.new_label_outlined),
              border: OutlineInputBorder(),
              labelText: 'Assignment Name',
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              hintText: 'Enter the name of your assignment',
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: 390,
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _assignmentDueDateStartTime,
            obscureText: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_view_day_outlined),
                border: OutlineInputBorder(),
                labelText: 'Select due date and end time',
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                hintText: 'Select due date and end time for assignment'),
            onTap: () async {
              DatePicker.showDateTimePicker(context, showTitleActions: true,
                  onChanged: (date) {
                print(
                    'change $date in time zone ${date.timeZoneOffset.inHours}');
              }, onConfirm: (date) {
                _assignmentDueDateStartTime.text =
                    date.toString().substring(0, 16);
              }, currentTime: DateTime.now());
            },
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: 390,
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _assignmentDueDateEndTime,
            obscureText: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_view_day_outlined),
                border: OutlineInputBorder(),
                labelText: 'Select due date and end time',
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                hintText: 'Select due date and end time for assignment'),
            onTap: () async {
              DatePicker.showDateTimePicker(context, showTitleActions: true,
                  onChanged: (date) {
                print(
                    'change $date in time zone ${date.timeZoneOffset.inHours}');
              }, onConfirm: (date) {
                _assignmentDueDateEndTime.text =
                    date.toString().substring(0, 16);
              }, currentTime: DateTime.now());
            },
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
          onPressed: () {
            setState(() {
              _courseName.toString().isEmpty &&
                      _assignmentName.text.isEmpty &&
                      _assignmentDueDateStartTime.text.isEmpty
                  ? _validate = true
                  : _validate = false;
            });

            user.updateAssignment(
              courseName: courseNameG,
              assignmentName: _assignmentName.text,
              assignmentDueDateStartTime: _assignmentDueDateStartTime.text,
              assignmentDueDateEndTime: _assignmentDueDateEndTime.text,
              assignmentState: '0',
              assignmentTimeRemaining: '0',
            );
            Navigator.pushReplacementNamed(context, RouteGenerator.home);
          },
          child: const Text(
            'Add Assignment',
          ),
        ),
      ]),
    );
  }
}
