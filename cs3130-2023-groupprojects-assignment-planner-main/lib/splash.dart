// ignore_for_file: depend_on_referenced_packages

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:assignment_planner/assignment_planner/views/login_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // _navToHome();
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return AnimatedSplashScreen(
      splash: Container(
          height: 100,
          child: Image.asset(
            "assets/images/uap.png",
            scale: 0.5,
          )),
      nextScreen: Login(),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
    );
  }
}
