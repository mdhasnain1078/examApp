import 'package:examapp/configs/theme/appColors.dart';
import 'package:examapp/controller/auth_controller.dart';
import 'package:examapp/widgets/common/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: mainGradient()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/app_splash_logo.png",
              width: 300,
              height: 300,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: Text(
                "This study app, you can use it as you want. you the access to all material in the course",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: onSurfaceTextColor, fontWeight: FontWeight.bold),
              ),
            ),
            MainBtton(
              onTap: () {
                controller.singInWithGoogle();
              },
              child: Stack(children: [
                Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    child: SvgPicture.asset("assets/icons/google.svg")),
                Center(
                  child: Text(
                    "Sign in with google",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
