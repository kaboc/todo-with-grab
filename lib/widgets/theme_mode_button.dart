import 'package:flutter/material.dart';

import 'package:todo_with_grab/common/_common.dart';

class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return IconButton(
      tooltip: 'Toggle theme mode',
      icon: Icon(
        Icons.mode_night,
        color: isDark ? Colors.yellow : null,
      ),
      onPressed: () => settingsNotifierPot().switchThemeMode(
        isDark ? ThemeMode.light : ThemeMode.dark,
      ),
    );
  }
}
