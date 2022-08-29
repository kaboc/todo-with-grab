import 'package:flutter/material.dart';
import 'package:test/test.dart';

import 'package:hive/hive.dart';
import 'package:pot/pot.dart';

import 'package:todo_with_grab/common/_common.dart';

import 'db.dart';
import 'utils.dart';

SettingsNotifier get settingsNotifier => settingsNotifierPot();

TodoListNotifier get todosNotifier => todoListNotifierPot();

void main() {
  late final Box<Settings> settingsBox;
  late final Box<Todo> todoBox;

  setUpAll(() async {
    Pot.forTesting = true;
    dbPot.replaceForTesting(() => TestDb());

    final db = dbPot();
    await db.init();
    settingsBox = db.settingsBox;
    todoBox = db.todoBox;
  });

  tearDownAll(() async {
    final db = dbPot();
    await (db as TestDb).dispose();
  });

  group('Settings', () {
    setUp(() async {
      settingsRepositoryPot.reset();
      settingsNotifierPot.reset();
      await settingsBox.clear();
    });

    test('Theme mode defaults to ThemeMode.system', () {
      expect(settingsBox.get(SettingsRepository.key)?.themeMode, null);
      expect(settingsNotifier.value.themeMode, equals(ThemeMode.system));
    });

    test('switchThemeMode() updates theme mode', () async {
      await settingsNotifier.switchThemeMode(ThemeMode.dark);
      final mode = settingsBox.get(SettingsRepository.key)?.themeMode;
      expect(mode, equals(ThemeMode.dark));
      expect(settingsNotifier.value.themeMode, equals(ThemeMode.dark));
    });
  });

  group('Todo', () {
    setUp(() async {
      todosRepositoryPot.reset();
      todoListNotifierPot.reset();
      await todoBox.clear();
    });

    test('Todo list is initially empty', () {
      expect(todoBox.isEmpty, isTrue);
      expect(todosNotifier.value.all, isEmpty);
    });

    test('add() adds uncompleted todo', () async {
      await addTodo('abc');
      expect(todoBox.getAt(0)?.description, equals('abc'));
      expect(todoBox.getAt(0)?.completed, isFalse);
      expect(todosNotifier.value.all.first.description, equals('abc'));
      expect(todosNotifier.value.all.first.completed, isFalse);
    });

    test('updateDescription() updates todo description', () async {
      await addTodo('abc');
      todosNotifier.editController.text = 'def';
      await todosNotifier.updateDescription(todoBox.getAt(0)!);
      expect(todoBox.getAt(0)?.description, equals('def'));
      expect(todoBox.getAt(0)?.completed, isFalse);
      expect(todosNotifier.value.all.first.description, equals('def'));
      expect(todosNotifier.value.all.first.completed, isFalse);
    });

    test('updateCompletion() updates todo status', () async {
      await addTodo('abc');
      await todosNotifier.updateCompletion(todoBox.getAt(0)!, completed: true);
      expect(todoBox.getAt(0)?.description, equals('abc'));
      expect(todoBox.getAt(0)?.completed, isTrue);
      expect(todosNotifier.value.all.first.description, equals('abc'));
      expect(todosNotifier.value.all.first.completed, isTrue);
    });

    test('remove() removes todo', () async {
      await addMultipleTodos(['abc', 'def', 'ghi']);
      expect(todosNotifier.value.all, hasLength(3));

      await todosNotifier.remove(todoBox.getAt(1)!);
      expect(todoBox.values, hasLength(2));
      expect(todoBox.getAt(0)?.description, equals('abc'));
      expect(todosNotifier.value.all[1].description, equals('abc'));
      expect(todoBox.getAt(1)?.description, equals('ghi'));
      expect(todosNotifier.value.all[0].description, equals('ghi'));
    });

    test('switchFilter() applies filter to todos', () async {
      await addMultipleTodos(['abc', 'def', 'ghi']);
      await todosNotifier.updateCompletion(
        todosNotifier.value.all[1],
        completed: true,
      );

      todosNotifier.switchFilter(TodoFilter.all);
      expect(todosNotifier.value.filtered, hasLength(3));

      todosNotifier.switchFilter(TodoFilter.active);
      expect(todosNotifier.value.filtered, hasLength(2));
      expect(todosNotifier.value.filtered[0].description, equals('ghi'));
      expect(todosNotifier.value.filtered[1].description, equals('abc'));

      todosNotifier.switchFilter(TodoFilter.completed);
      expect(todosNotifier.value.filtered, hasLength(1));
      expect(todosNotifier.value.filtered[0].description, equals('def'));
    });
  });
}
