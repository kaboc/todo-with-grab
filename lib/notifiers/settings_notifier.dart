import 'package:flutter/material.dart';

import 'package:todo_with_grab/common/_common.dart';

export 'package:todo_with_grab/models/settings.dart';

class SettingsNotifier extends ValueNotifier<Settings> {
  SettingsNotifier() : super(const Settings()) {
    _repository.onChange((settings) => value = settings);
  }

  final _repository = settingsRepositoryPot();

  void switchThemeMode(ThemeMode mode) {
    final settings = value.copyWith(themeMode: mode);
    _repository.update(settings);
  }
}
