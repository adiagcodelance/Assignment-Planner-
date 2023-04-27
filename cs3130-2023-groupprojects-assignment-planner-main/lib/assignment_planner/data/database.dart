import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class AssignmentDatabase {
//the real-time database
  late final DatabaseReference ref;
  AssignmentDatabase({ref})
      : ref = ref ?? FirebaseDatabase.instance.reference().child("Users");

  //retrieve data from our database
  Future<String> get(String email) async {
    final userLogin = await ref.child(email).get().then((value) => value.value)
        as Map<dynamic, dynamic>;
    return await userLogin.values.first;
  }
  //replace the data set in database with a whole new one
  Future<void> update(String global, String email) async {
    ref.child(email).update({"userinfo": global});
  }
}
