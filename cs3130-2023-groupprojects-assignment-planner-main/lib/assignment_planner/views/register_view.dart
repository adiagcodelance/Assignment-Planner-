//may not be neededimport 'package:alpha_noname/model/user_item.dart';

import 'package:assignment_planner/assignment_planner/planner_cubit/planner_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assignment_planner/assignment_planner/colors/colors.dart';

import '../routes/route_generator.dart';

var user = PlannerCubit();

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupState();
}

class _SignupState extends State<SignupView> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _email = TextEditingController();
  final _studentID = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(
          "UAP",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Sign up',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        signupContainer()
      ]),
    );
  }

  Widget signupContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 280,
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _username,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              labelText: 'Username',
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              hintText: 'Enter username',
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 280,
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _password,
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                labelText: 'Password',
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                hintText: 'Enter Password'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 280,
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _confirmPassword,
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                labelText: 'Confirm Password',
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                hintText: 're-enter password'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 280,
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _email,
            obscureText: false,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                labelText: 'Email',
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                hintText: 'Enter valid email address'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 280,
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _studentID,
            obscureText: false,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                labelText: 'Student ID',
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                hintText: 'Enter Student ID'),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account?  '),
              InkWell(
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.purple,
                      decoration: TextDecoration.underline),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
          onPressed: () {
            if (_username.text.isEmpty && _password.text.isEmpty) {
              setState(() {
                _username.text.isEmpty && _password.text.isEmpty
                    ? _validate = true
                    : _validate = false;
              });
            }

            register(_username.text.trim(), _password.text.trim(),
                _email.text.trim(), _studentID.text.trim());
          },
          child: const Text('Sign up'),
        ),
      ],
    );
  }

  register(String username, password, email, studentID) async {
    try {
      if (passwordConfirmed()) {
        // UserCredential userCredential = await FirebaseAuth.instance
        //     .createUserWithEmailAndPassword(
        //         email: _username, password: _password);
        // adduser(_username, _password, _email, _StudentID);
        await user.signup(
            username: username, password: password, email: email, schoolID: 0);
        Navigator.pop(context, RouteGenerator.login);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _validate = false;
        _validate ? 'Password is to weak' : null;
      } else if (e.code == 'email-already-in-use') {
        _validate = false;
        _validate ? 'User exists' : null;
      }
    } catch (e) {
      print(e);
    }
  }

  bool passwordConfirmed() {
    if (_password.text.trim() == _confirmPassword.text.trim()) {
      return true;
    }
    return false;
  }

  Future adduser(
      String username, String password, String email, int studentID) async {
    var currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      user.signup(
          username: username,
          password: password,
          email: email,
          schoolID: studentID);
    }
  }
}
