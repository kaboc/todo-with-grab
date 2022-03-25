import 'package:flutter/material.dart';

class AppTheme {
  static final _lightScheme = ColorScheme.fromSeed(
    seedColor: Colors.blue,
  );

  static final _darkScheme = ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  );

  static ThemeData get light {
    return ThemeData.from(colorScheme: _lightScheme);
  }

  static ThemeData get dark {
    return ThemeData.from(colorScheme: _darkScheme).copyWith(
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(_darkScheme.secondary),
      ),
    );
  }
}

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  bool get isDark => theme.brightness == Brightness.dark;

  Color get primaryColor => theme.colorScheme.primary;

  Color get secondaryColor => theme.colorScheme.secondary;

  Color get inversePrimaryColor => theme.colorScheme.inversePrimary;

  TextStyle get subtitle1 => theme.textTheme.subtitle1!;
}
