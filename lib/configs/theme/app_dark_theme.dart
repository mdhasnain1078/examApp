import 'package:examapp/configs/theme/sub_theme_data_mixin.dart';
import 'package:flutter/material.dart';

const Color primaryColorDark1 = Color(0xFF2e3c62);
const Color primaryColorDark2 = Color(0xFF99ace1);
const mainTextColorDark = Colors.white;

class DarkTheme with SubThemeData {
  builddarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
        iconTheme: getIconTheme(),
        textTheme: getTextThemes().apply(
            bodyColor: mainTextColorDark, displayColor: mainTextColorDark));
  }
}
