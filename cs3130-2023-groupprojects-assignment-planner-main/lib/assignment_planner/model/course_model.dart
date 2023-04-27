import 'assignment_model.dart';

///A model for course information
class CourseModel {
  String courseName;
  String courseNumber;
  List<AssignmentModel>? assignmentList = [];
  CourseModel(this.courseName, this.courseNumber, [this.assignmentList]);

  Map toJson() {
    return {
      "courseName": courseName,
      "courseNumber": courseNumber,
      "assignmentList": assignmentList
    };
  }

  factory CourseModel.fromJson(dynamic jsonStr) {
    //var jsonObj=json.decode(jsonStr);
    if (jsonStr['assignmentList'] != null) {
      var assignmentObjJson = jsonStr['assignmentList'] as List;
      List<AssignmentModel> assignmentList = assignmentObjJson
          .map((assignmentJson) => AssignmentModel.fromJson(assignmentJson))
          .toList();

      return CourseModel(jsonStr['courseName'] as String,
          jsonStr['courseNumber'] as String, assignmentList);
    } else {
      return CourseModel(
          jsonStr['courseName'] as String, jsonStr['courseNumber'] as String);
    }
  }

  @override
  String toString() {
    return '{ $courseName, $courseNumber, $assignmentList }';
  }
}
