import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;

import 'package:todo_with_grab/common/_common.dart';

class TestDb extends Db {
  String get _dbDir => path.join(Directory.current.path, 'test', 'db');

  @override
  Future<void> init() async {
    Hive
      ..init(_dbDir)
      ..registerAdapter(TodoAdapter())
      ..registerAdapter(SettingsAdapter());

    todoBox = await Hive.openBox<Todo>('todoBox');
    settingsBox = await Hive.openBox<Settings>('settingsBox');
  }

  @override
  Future<void> dispose() async {
    await Hive.deleteFromDisk();
    File(_dbDir).deleteSync(recursive: true);

    super.dispose();
  }
}
