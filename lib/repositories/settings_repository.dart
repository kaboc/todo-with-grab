import 'dart:async';
import 'package:meta/meta.dart';

import 'package:hive/hive.dart';

import 'package:todo_with_grab/common/_common.dart';

class SettingsRepository {
  @visibleForTesting
  static const key = 'settings';

  Box<Settings> get _box => dbPot().settingsBox;

  StreamSubscription<BoxEvent>? _subscription;

  void dispose() {
    _subscription?.cancel();
  }

  void onChange(void Function(Settings) listener) {
    listener(_box.get(key) ?? const Settings());

    _subscription = _box
        .watch(key: key)
        .listen((event) => listener(event.value as Settings));
  }

  Future<void> update(Settings settings) async {
    await _box.put(key, settings);
  }
}
