import 'package:assignment_planner/assignment_planner/views/login_view.dart';
import 'package:flutter/material.dart';

import '../routes/route_generator.dart';
import 'login_view.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () {
              //user.Logout();
              Navigator.pushReplacementNamed(context, RouteGenerator.login);
            },
            child: const Text(
              'Logout',
            ),
          ),
        )
      ]),
    );
  }
}
