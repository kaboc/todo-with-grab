import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class AppTheme {
  static final ColorScheme _lightScheme = .fromSeed(
    seedColor: Colors.blue,
  );

  static final ColorScheme _darkScheme = .fromSeed(
    seedColor: Colors.blue,
    brightness: .dark,
  );

  static ThemeData get light {
    return .from(colorScheme: _lightScheme);
  }

  static ThemeData get dark {
    return .from(colorScheme: _darkScheme).copyWith(
      checkboxTheme: .new(
        fillColor: .all(_darkScheme.secondary),
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

  TextStyle get titleMedium => theme.textTheme.titleMedium!;
}
