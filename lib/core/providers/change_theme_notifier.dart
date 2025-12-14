import 'package:expenses/core/constants.dart';
import 'package:expenses/core/helper_function/light_dark_mode.dart';
import 'package:expenses/core/utils/shared_preferences_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeThemeNotifier extends Notifier<ThemeData> {
  bool isLight = !Prefs.getBool(kTheme);

  @override
  ThemeData build() {
    return Prefs.getBool(kTheme) ? darkMode : lightMode;
  }

  void toggleTheme() {
    if (state == lightMode) {
      state = darkMode;
      isLight = false;
      Prefs.setBool(kTheme, true);
    } else {
      state = lightMode;
      isLight = true;
      Prefs.setBool(kTheme, false);
    }
  }
}

final changeThemeNotifierProvider =
    NotifierProvider<ChangeThemeNotifier, ThemeData>(
      () => ChangeThemeNotifier(),
    );
