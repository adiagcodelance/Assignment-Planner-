import 'dart:convert';

import 'package:assignment_planner/assignment_planner/data/operating_data.dart';
import 'package:assignment_planner/assignment_planner/interface/interface_operating_CA.dart';
import 'package:assignment_planner/assignment_planner/model/assignment_model.dart';
import 'package:assignment_planner/assignment_planner/model/course_model.dart';
import 'package:assignment_planner/assignment_planner/model/user_course_assignment_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../views/calender_view.dart';

part 'planner_state.dart';

class PlannerCubit extends Cubit<PlannerState> {
  late GlobalModel userInfo;
  late String userName;
  late String userEmail;
  late int index;

  PlannerCubit() : super(PlannerInitial());

  reloadCalender() {
    Calender();
  }

  //if userInfo has data, it means login success.
  Future<void> login(
      {required String useremail, required String password}) async {
    userEmail = _formatEmail(useremail);
    iOperatingCA userLogin = OperatingCA();
    var userInfoStr = await userLogin.selectTo(
        userInfo:
            userEmail); //change the JSON info that receive from data layer to userModel
    GlobalModel userInfoObj = GlobalModel.fromJson(userInfoStr);
    if (userInfoObj.userPassword == password) {
      userInfo = userInfoObj;
      userName = userInfoObj.userName;
      userEmail = userInfoObj.userMail;

      //update due date
      _updateTimeRemainingAuto();
      //update date
      await _updateData();

      emit(Logined());
    } else {
      emit(LoginFailed());
    }
  }

  Future<void> logout(
      {required String useremail, required String password}) async {}

  String _formatEmail(String email) {
    return email.replaceAll('.', '*');
  }

  //if sign up success, then login to the system, else change the state to login failed.
  Future<void> signup(
      {required String username,
      required String password,
      required String email,
      required int schoolID}) async {
    var email0 = _formatEmail(email);
    iOperatingCA userSignup = OperatingCA();
    if (userSignup.insertTo(
        userInfo: email0,
        userObjStr: jsonEncode(GlobalModel(username, email0, password, [])))) {
      //login(useremail: _email, password: password);
    } else {
      emit(LoginFailed());
    }
  }

  void updateIndex({required int i}) {
    index = i;
  }

  void insertCourse(
      {required String courseName, required String courseNumber}) {
    updateCourse(courseName: courseName, courseNumber: courseNumber);
  }

  ///update course info
  Future<void> updateCourse(
      {required String courseName, required String courseNumber}) async {
    var flag = false;

    //search if the course exist
    //course.courseName == courseName &&
    for (var course in userInfo.courseList!) {
      if (course.courseNumber == courseNumber) {
        course.courseName = courseName;
        flag = true;
        break;
      }
    }
    //if the course does not exist, add it.
    if (flag == false) {
      userInfo.courseList?.add(CourseModel(courseName, courseNumber, []));
      _updateTimeRemainingAuto();
    }
    await _updateData();
  }

  deleteCourse(
      {required String courseName, required String courseNumber}) async {
    for (var courseItem in userInfo.courseList!) {
      //find the course that will be deleted
      if (courseItem.courseName == courseName &&
          courseItem.courseNumber == courseNumber) {
        //confirm if the course has assignment
        //the course can be deleted if it does not contains any assignments.
        if (courseItem.assignmentList!.isEmpty) {
          userInfo.courseList?.remove(courseItem);
          _updateTimeRemainingAuto();
          await _updateData();
          return "The course has been deleted.";
        } else {
          return "You cannot delete a course that has assignment record(s).";
        }
      } else {
        return "The course name or course number is incorrect, deleting cannot be done.";
      }
    }
  }

  Future<void> updateAssignment(
      {required String courseName,
      required String assignmentName,
      required String assignmentDueDateStartTime,
      required String assignmentDueDateEndTime,
      required String assignmentState,
      required String assignmentTimeRemaining}) async {
    for (var courseItem in userInfo.courseList!) {
      //find the course that will be deleted
      if (courseItem.courseName == courseName) {
        var flag = false;
        for (var assignment in courseItem.assignmentList!) {
          if (assignment.assignmentName == assignmentName) {
            flag = true;
            break;
          }
        }
        if (flag == false) {
          courseItem.assignmentList?.add(AssignmentModel(
              assignmentName,
              assignmentDueDateStartTime,
              assignmentDueDateEndTime,
              assignmentState,
              assignmentTimeRemaining));
          _updateTimeRemainingAuto();
        }
        await _updateData();
      }
    }
  }

  Future<void> deleteAssignment(
      {required String courseName, required String assignmentName}) async {
    for (var courseItem in userInfo.courseList!) {
      if (courseItem.courseName == courseName) {
        for (var assignmentItem in courseItem.assignmentList!) {
          if (assignmentItem.assignmentName == assignmentName) {
            courseItem.assignmentList?.remove(assignmentItem);
            break;
          }
        }
        _updateTimeRemainingAuto();
        await _updateData();
      }
    }
  }

  Future<void> doneAssignment(
      {required String courseName, required String assignmentName}) async {
    for (var courseItem in userInfo.courseList!) {
      if (courseItem.courseName == courseName) {
        for (var assignment in courseItem.assignmentList!) {
          if (assignment.assignmentName == assignmentName) {
            assignment.assignmentState = '1';
            _updateTimeRemainingAuto();
            await _updateData();
          }
        }
      }
    }
  }

  Future<void> _updateData() async {
    iOperatingCA assignmentUpdating = OperatingCA();
    assignmentUpdating.insertTo(
        userInfo: userEmail, userObjStr: jsonEncode(userInfo));
  }

  int _timeRemaining(String duedate) {
    DateTime dueDate = DateTime.parse(duedate);
    // List<String> time = duedate.split(' ')[0].split('-');
    // DateTime dueDate =
    //     DateTime(int.parse(time[0]), int.parse(time[1]), int.parse(time[2]));
    Duration diff = DateTime.now().difference(dueDate);
    return diff.inSeconds;
  }

  void _updateTimeRemainingAuto() {
    for (var course in userInfo.courseList!) {
      for (var assignment in course.assignmentList!) {
        assignment.assignmentTimeRemaining =
            _timeRemaining(assignment.assignmentDueDateEndTime)
                .abs()
                .toString();
      }
    }
  }
}
