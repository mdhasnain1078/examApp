import 'package:examapp/configs/theme/appColors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(gradient: mainGradient()),
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/app_splash_logo.png",
              height: 200,
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
