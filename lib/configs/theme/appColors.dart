import 'package:examapp/configs/theme/app_light_theme.dart';
import 'package:examapp/configs/theme/ui_parameters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_dark_theme.dart';

const Color onSurfaceTextColor = Colors.white;
const Color correctAnswerColor = Color(0xFF3ac3cb);
const Color wrongAnswerColor = Color(0xFFf85187);
const Color notAnsweredColor = Color(0xFF2a3c65);

const mainGredientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColorLight1, primaryColorLight2]);

const mainGredientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColorDark1, primaryColorDark2]);

LinearGradient mainGradient() {
  return UIParameters.isDarkMode() ? mainGredientDark : mainGredientLight;
}

CustomScaffoldColor(BuildContext context) => Get.isDarkMode
    ? const Color(0xFF2e3c62)
    : const Color.fromARGB(255, 240, 237, 255);

Color answerSelectedColor() => UIParameters.isDarkMode()
    ? Theme.of(Get.context!).cardColor.withOpacity(0.5)
    : Theme.of(Get.context!).primaryColor;

Color answeBorderColor() => UIParameters.isDarkMode()
    ? const Color.fromARGB(255, 20, 46, 158)
    : const Color.fromARGB(255, 221, 221, 221);
