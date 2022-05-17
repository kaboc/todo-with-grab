import 'package:flutter/foundation.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:todo_with_grab/common/_common.dart';

class Db {
  late final Box<Todo> todoBox;
  late final Box<Settings> settingsBox;

  Future<void> init() async {
    if (!kIsWeb) {
      final dir = await getApplicationSupportDirectory();
      Hive.init(dir.path);
    }

    Hive
      ..registerAdapter(TodoAdapter())
      ..registerAdapter(SettingsAdapter());

    todoBox = await Hive.openBox<Todo>('todoBox');
    settingsBox = await Hive.openBox<Settings>('settingsBox');
  }
}
