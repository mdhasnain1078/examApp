import 'package:examapp/configs/theme/appColors.dart';
import 'package:examapp/widgets/app_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star_sharp,
                size: 65,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'This is a study app. You can use it as you want. if you understand how this works, you would be able to scale it',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              AppCircleButton(
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 35,
                ),
                onTap: () => Get.offAllNamed("/home"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
