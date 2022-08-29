import 'package:flutter/material.dart';

import 'package:todo_with_grab/common/_common.dart';

export 'package:todo_with_grab/models/settings.dart';

class SettingsNotifier extends ValueNotifier<Settings> {
  SettingsNotifier() : super(const Settings()) {
    _repository.onChange((settings) => value = settings);
  }

  SettingsRepository get _repository => settingsRepositoryPot();

  Future<void> switchThemeMode(ThemeMode mode) async {
    final settings = value.copyWith(themeMode: mode);
    await _repository.update(settings);
  }
}
