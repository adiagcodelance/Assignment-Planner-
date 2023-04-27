import 'package:assignment_planner/assignment_planner/model/login_model.dart';
import 'package:assignment_planner/assignment_planner/model/user_course_assignment_model.dart';

///An interface for login
abstract class ILogin {
  //login method
  GlobalModel loginTo(LoginModel userLogin);
}
