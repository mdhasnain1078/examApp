import 'package:examapp/configs/theme/sub_theme_data_mixin.dart';
import 'package:flutter/material.dart';

const Color primaryColorLight1 = Color(0xFF3ac3cb);
const Color primaryColorLight2 = Color(0xFFf85187);
const Color mainTextColorLight = Color.fromARGB(255, 40, 40, 40);
const Color cardColor = Color.fromARGB(255, 254, 254, 255);

class LightTheme with SubThemeData {
  buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      primaryColor: primaryColorLight2,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: getIconTheme(),
      cardColor: cardColor,
      textTheme: getTextThemes().apply(
          bodyColor: mainTextColorLight, displayColor: mainTextColorLight),
    );
  }
}
