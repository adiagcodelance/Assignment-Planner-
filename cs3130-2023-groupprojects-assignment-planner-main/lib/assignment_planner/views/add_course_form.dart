import 'package:assignment_planner/assignment_planner/colors/colors.dart';
import 'package:assignment_planner/assignment_planner/routes/route_generator.dart';
import 'package:flutter/material.dart';

import 'login_view.dart';

class CourseForm extends StatefulWidget {
  @override
  State<CourseForm> createState() => CourseFormState();
}

class CourseFormState extends State<CourseForm> {
  final _courseName = TextEditingController();
  final _courseNumber = TextEditingController();

  bool _validate = false;

  @override
  void dispose() {
    _courseName.dispose();
    _courseNumber.dispose();
    super.dispose();
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
      body: newCourseForm(),
    );
  }

  Widget newCourseForm() {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          height: 50,
        ),
        Text(
          'New Course          ',
          style: TextStyle(fontSize: 35),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 20),
        Container(
          //alignment: Alignment.center,
          width: 390,
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _courseName,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.list_alt_outlined),
              border: OutlineInputBorder(
                  //borderRadius: BorderRadius.all(
                  //Radius.circular(30.0),
                  //),
                  ),
              labelText: 'Course Name',
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              hintText: 'Enter the course',
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          //alignment: Alignment.center,
          width: 390,
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _courseNumber,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.new_label_outlined),
              border: OutlineInputBorder(
                  //borderRadius: BorderRadius.all(
                  //Radius.circular(30.0),
                  //),
                  ),
              labelText: 'Course Number',
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              hintText: 'Enter your course number',
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
          onPressed: () {
            setState(() {
              _courseName.text.isEmpty &&
                      _courseName.text.isEmpty &&
                      _courseNumber.text.isEmpty
                  ? _validate = true
                  : _validate = false;
            });

            user.insertCourse(
              courseName: _courseName.text,
              courseNumber: _courseNumber.text,
            );
            Navigator.pushReplacementNamed(context, RouteGenerator.home);
          },
          child: const Text(
            'Add Course',
          ),
        ),
      ]),
    );
  }
}
