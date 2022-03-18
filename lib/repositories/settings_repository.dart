import 'dart:async';

import 'package:hive/hive.dart';

import 'package:todo_with_grab/common/_common.dart';

const _key = 'settings';

class SettingsRepository {
  final _box = dbPot().settingsBox;

  StreamSubscription<BoxEvent>? _subscription;

  void dispose() {
    _subscription?.cancel();
  }

  void onChange(void Function(Settings) listener) {
    listener(_box.get(_key) ?? const Settings());

    _subscription = _box
        .watch(key: _key)
        .listen((event) => listener(event.value as Settings));
  }

  Future<void> update(Settings settings) async {
    await _box.put(_key, settings);
  }
}
