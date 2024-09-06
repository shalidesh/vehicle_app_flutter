import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'Home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AnimatedSplashScreen(
          splash: Lottie.asset('assets/car.json'),
          backgroundColor: Colors.red,
          nextScreen: Home(),
          splashIconSize: 500,
          duration: 5000,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.leftToRightWithFade,
          animationDuration: const Duration(seconds: 4),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 250.0),
          child: Text("I'm Guid You",
              style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Roboto',
                  decoration: TextDecoration.none,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold)),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 230.0),
          child: Text('Let us give the best Prediction',
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  decoration: TextDecoration.none,
                  color: Color.fromARGB(255, 8, 248, 88),
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
