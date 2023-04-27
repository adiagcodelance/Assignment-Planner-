import 'package:assignment_planner/assignment_planner/routes/route_generator.dart';
import 'package:assignment_planner/assignment_planner/planner_cubit/planner_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ///register test
  var test = PlannerCubit();
  //await test.signup(username: "Tessssst", password: "123456", email: "test@upei.ca", schoolID: 0);

  ///login test
  //await test.login(useremail: "test@upei.ca", password: "123456");

  ///add course test
  //test.insertCourse(CourseName: "Cloud Computing", CourseNumber: "CS 5110");
  //  test.insertCourse(CourseName: "Machine Learning", CourseNumber: "CS 4210");
  //  test.insertCourse(CourseName: "Tutoring in Math, Comp. Sci", CourseNumber: "CS 3050");
  //  test.insertCourse(CourseName: "Computer science I", CourseNumber: "CS 1910");
  //
  // ///add assignment test
  // test.updateAssignment(courseName: "Machine Learning", assignmentName: "assignment 1", assignmentDueDate: "2023-4-30", assignmentState: "0", assignmentTimeRemaining: "20");
  // test.updateAssignment(courseName: "Machine Learning", assignmentName: "assignment 2", assignmentDueDate: "2023-4-30", assignmentState: "0", assignmentTimeRemaining: "20");
  // test.updateAssignment(courseName: "Tutoring in Math, Comp. Sci", assignmentName: "assignment 1", assignmentDueDate: "2023-4-30", assignmentState: "0", assignmentTimeRemaining: "20");
  // test.updateAssignment(courseName: "Computer science I", assignmentName: "assignment 1", assignmentDueDate: "2023-4-30", assignmentState: "0", assignmentTimeRemaining: "20");

  ///Done an assignment
  //test.doneAssignment(courseName: "Machine Learning", assignmentName: "assignment 1");

  ///delete assignment test
  test.deleteAssignment(
      courseName: "Tutoring in Math, Comp. Sci",
      assignmentName: "assignment 1");

  ///delete course test
  test.deleteCourse(courseName: "Machine Learning", courseNumber: "CS 4210");
  test.deleteCourse(
      courseName: "Tutoring in Math, Comp. Sci", courseNumber: "CS 3050");

  runApp(MyApp());
}

//Main app which will start our logo/loading, then call the other views from
//button navigation/login
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'AUP',
      theme: ThemeData(
          //backgroundColor: Colors.white,
          ),
      initialRoute: RouteGenerator.splashPage,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
