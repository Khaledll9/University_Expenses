import 'package:expenses/core/helper_function/light_dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeThemeNotifier extends Notifier<ThemeData> {
  bool isLight = true;

  @override
  ThemeData build() {
    return lightMode;
  }

  void toggleTheme() {
    if (state == lightMode) {
      state = darkMode;
      isLight = false;
    } else {
      state = lightMode;
      isLight = true;
    }
  }
}

final changeThemeNotifierProvider =
    NotifierProvider<ChangeThemeNotifier, ThemeData>(
      () => ChangeThemeNotifier(),
    );
