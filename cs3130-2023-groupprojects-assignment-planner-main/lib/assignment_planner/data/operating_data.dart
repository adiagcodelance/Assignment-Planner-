import 'package:assignment_planner/assignment_planner/interface/interface_operating_CA.dart';

import 'database.dart';

class OperatingCA implements iOperatingCA {
  AssignmentDatabase db = AssignmentDatabase();
  @override
  Future<String> selectTo({required String userInfo}) async {
    return await db.get(userInfo);
  }

  @override
  bool insertTo({required String userInfo, required String userObjStr}) {
    db.update(userObjStr, userInfo);
    return true;
  }

  @override
  bool updateTo({required String userInfo, required String userObjStr}) {
    db.update(userObjStr, userInfo);
    return true;
  }
}
