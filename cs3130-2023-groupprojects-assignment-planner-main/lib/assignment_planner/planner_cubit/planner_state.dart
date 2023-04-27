part of 'planner_cubit.dart';

@immutable
abstract class PlannerState {}

class PlannerInitial extends PlannerState {}

//this state means the user has logged in.
class Logined extends PlannerState {}

class LoginFailed extends PlannerState {}

class Updated extends PlannerState {}

class UpdateFailed extends PlannerState {}
