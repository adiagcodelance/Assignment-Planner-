///A model for assignment information
class AssignmentModel {
  late String assignmentName;
  late String assignmentDueDateStartTime;
  late String assignmentDueDateEndTime;
  late String assignmentState;
  late String assignmentTimeRemaining;

  AssignmentModel(
      this.assignmentName,
      this.assignmentDueDateStartTime,
      this.assignmentDueDateEndTime,
      this.assignmentState,
      this.assignmentTimeRemaining);

  Map toJson() {
    return {
      "assignmentName": assignmentName,
      "assignmentDueDateStartTime": assignmentDueDateStartTime,
      "assignmentDueDateEndTime": assignmentDueDateEndTime,
      "assignmentState": assignmentState,
      "assignmentTimeRemaining": assignmentTimeRemaining
    };
  }

  factory AssignmentModel.fromJson(dynamic jsonStr) {
    //var jsonObj=json.decode(jsonStr);
    return AssignmentModel(
        jsonStr['assignmentName'] as String,
        jsonStr['assignmentDueDateStartTime'] as String,
        jsonStr['assignmentDueDateEndTime'] as String,
        jsonStr['assignmentState'] as String,
        jsonStr['assignmentTimeRemaining'] as String);
  }

  @override
  String toString() {
    return '{ $assignmentName, $assignmentDueDateStartTime, $assignmentDueDateEndTime, $assignmentState, $assignmentTimeRemaining }';
  }
}
