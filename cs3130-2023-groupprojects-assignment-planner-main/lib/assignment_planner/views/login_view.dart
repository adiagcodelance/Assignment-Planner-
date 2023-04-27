import 'package:assignment_planner/assignment_planner/colors/colors.dart';
import 'package:assignment_planner/assignment_planner/planner_cubit/planner_cubit.dart';
import 'package:assignment_planner/assignment_planner/routes/route_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const users = {'admin@mail.ca': 'admin1234'};
var user = PlannerCubit();

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

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
        body: loginContainer());
  }

  Widget loginContainer() {
    //loggedIn();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Login',
          style: TextStyle(fontSize: 40),
        ),
        Container(
          alignment: Alignment.center,
          width: 280,
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _email,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              labelText: 'User Name',
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              hintText: 'Enter valid mail id as abc@gmail.com',
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
                hintText: 'Enter your secure password'),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account?  '),
              InkWell(
                child: Text(
                  'Sign up',
                  style: TextStyle(
                      color: Colors.purple,
                      decoration: TextDecoration.underline),
                ),
                onTap: () {
                  Navigator.pushNamed(context, RouteGenerator.signup);
                },
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
          onPressed: () {
            setState(() {
              _email.text.isEmpty && _password.text.isEmpty
                  ? _validate = true
                  : _validate = false;
            });
            signin(_email.text, _password.text);
          },
          child: const Text('Login'),
        ),
      ],
    );
  }

  signin(String username, password) async {
    try {
      // final credential = await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(email: _username, password: _password);
      await user.login(useremail: username, password: password);
      Navigator.pushReplacementNamed(context, RouteGenerator.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  loggedIn() {
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Navigator.pushReplacementNamed(context, RouteGenerator.home);
      }
    });
  }
}
