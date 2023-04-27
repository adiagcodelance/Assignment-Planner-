import 'dart:convert';

import 'course_model.dart';

class GlobalModel {
  String userName;
  String userMail;
  String userPassword;
  List<CourseModel>? courseList;

  GlobalModel(this.userName, this.userMail, this.userPassword,
      [this.courseList]);

  Map toJson() {
    return {
      "userName": userName,
      "userMail": userMail,
      "userPassword": userPassword,
      "courseList": courseList
    };
  }

  factory GlobalModel.fromJson(dynamic jsonStr) {
    var jsonObj = json.decode(jsonStr);
    if (jsonObj['courseList'] != null) {
      var courseObjsJson = jsonObj['courseList'] as List;
      List<CourseModel> coursetList = courseObjsJson
          .map((courseJson) => CourseModel.fromJson(courseJson))
          .toList();

      return GlobalModel(
          jsonObj['userName'] as String,
          jsonObj['userMail'] as String,
          jsonObj['userPassword'] as String,
          coursetList);
    } else {
      return GlobalModel(jsonObj['userName'] as String,
          jsonObj['userMail'] as String, jsonObj['userPassword'] as String);
    }
  }

  @override
  String toString() {
    return '{ $userName, $userMail, $userPassword, $courseList }';
  }
}
