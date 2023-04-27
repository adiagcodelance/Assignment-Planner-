import 'package:assignment_planner/assignment_planner/views/add_assignment_form.dart';
import 'package:assignment_planner/assignment_planner/views/add_course_form.dart';
import 'package:assignment_planner/assignment_planner/views/course_list_view.dart';
import 'package:assignment_planner/assignment_planner/views/edit_course.dart';
import 'package:assignment_planner/assignment_planner/views/register_view.dart';
import 'package:assignment_planner/splash.dart';
import 'package:flutter/material.dart';
import 'package:assignment_planner/assignment_planner/views/views.dart';

class RouteGenerator {
  //use consts to avoid typos and maintenance headaches
  static const String splashPage = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String assignmentForm = '/assignmentForm';
  static const String assignments = '/assignments';
  static const String courses = '/courses';
  static const String courseForm = '/courseform';
  static const String editCourseForm = '/editCourseform';
  static const String notification = '/notification';
  static const String calender = '/calender';

  //private constructor (no one should be constructing this class)
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return MaterialPageRoute(builder: (_) => const Splash());
      case login:
        return MaterialPageRoute(builder: (_) => Login());
      case signup:
        return MaterialPageRoute(builder: (_) => SignupView());
      case home:
        return MaterialPageRoute(builder: (_) => Home());
      case assignmentForm:
        return MaterialPageRoute(builder: (_) => AssignemntForm());
      case assignments:
        return MaterialPageRoute(builder: (_) => Assignments());
      case courses:
        return MaterialPageRoute(builder: (_) => Courses());
      case courseForm:
        return MaterialPageRoute(builder: (_) => CourseForm());
      case editCourseForm:
        return MaterialPageRoute(builder: (_) => EditCourseForm());
      case notification:
        return MaterialPageRoute(builder: (_) => Reminder());
      case calender:
        return MaterialPageRoute(builder: (_) => Calender());
      //handle missing routes!
      default:
        return MaterialPageRoute(builder: (_) => const Splash());
    }
  }
}
