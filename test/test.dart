import 'package:flutter/material.dart';

import 'package:hive_ce/hive_ce.dart';
import 'package:test/test.dart';

import 'package:todo_with_grab/common/_common.dart';

import 'db.dart';
import 'utils.dart';

SettingsNotifier get settingsNotifier => settingsNotifierPot();
TodoListNotifier get todosNotifier => todoListNotifierPot();

void main() {
  late final Box<Settings> settingsBox;
  late final Box<Todo> todoBox;

  setUpAll(() async {
    dbPot.replaceForTesting(TestDb.new);

    final db = dbPot();
    await db.init();
    settingsBox = db.settingsBox;
    todoBox = db.todoBox;
  });

  tearDownAll(() async {
    final db = dbPot();
    await (db as TestDb).dispose();
  });

  tearDown(() async {
    await settingsBox.clear();
    await todoBox.clear();
  });

  group('Settings', () {
    setUp(() async {
      settingsRepositoryPot.reset();
      settingsNotifierPot.reset();
      await settingsBox.clear();
    });

    test('Theme mode defaults to ThemeMode.system', () {
      expect(settingsBox.get(SettingsRepository.key)?.themeMode, null);
      expect(settingsNotifier.value.themeMode, ThemeMode.system);
    });

    test('switchThemeMode() updates theme mode', () async {
      await settingsNotifier.switchThemeMode(.dark);
      final mode = settingsBox.get(SettingsRepository.key)?.themeMode;
      expect(mode, ThemeMode.dark);
      expect(settingsNotifier.value.themeMode, ThemeMode.dark);
    });
  });

  group('Editing todo', () {
    test('Saving new todo adds uncompleted todo', () async {
      await addTodo('abc');

      final todo = todoBox.getAt(0)!;
      expect(todo.description, 'abc');
      expect(todo.completed, isFalse);
      expect(todosNotifier.value.all.first, todo);
    });

    test('Saving existing todo updates only description', () async {
      await addTodo('abc');

      final todo = todoBox.getAt(0)!;
      expect(todo.description, 'abc');
      expect(todo.completed, isFalse);

      todoEditNotifierPot.replace(() => TodoEditNotifier(initialTodo: todo));
      final editNotifier = todoEditNotifierPot()..updateDescription('def');
      await editNotifier.save();

      final updatedTodo = todoBox.getAt(0)!;
      expect(updatedTodo.description, 'def');
      expect(updatedTodo.createdAt, todo.createdAt);
      expect(updatedTodo.completed, todo.completed);
      expect(todosNotifier.value.all.first, updatedTodo);
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

    test('updateCompletion() updates todo status', () async {
      await addTodo('abc');
      await todosNotifier.updateCompletion(todoBox.getAt(0)!, completed: true);
      expect(todoBox.getAt(0)?.description, 'abc');
      expect(todoBox.getAt(0)?.completed, isTrue);
      expect(todosNotifier.value.all.first.description, 'abc');
      expect(todosNotifier.value.all.first.completed, isTrue);
    });

    test('remove() removes todo', () async {
      await addMultipleTodos(['abc', 'def', 'ghi']);
      expect(todosNotifier.value.all, hasLength(3));

      await todosNotifier.remove(todoBox.getAt(1)!);
      expect(todoBox.values, hasLength(2));
      expect(todoBox.getAt(0)?.description, 'abc');
      expect(todosNotifier.value.all[1].description, 'abc');
      expect(todoBox.getAt(1)?.description, 'ghi');
      expect(todosNotifier.value.all[0].description, 'ghi');
    });

    test('switchFilter() applies filter to todos', () async {
      await addMultipleTodos(['abc', 'def', 'ghi']);
      await todosNotifier.updateCompletion(
        todosNotifier.value.all[1],
        completed: true,
      );

      todosNotifier.switchFilter(.all);
      expect(todosNotifier.value.filtered, hasLength(3));

      todosNotifier.switchFilter(.active);
      expect(todosNotifier.value.filtered, hasLength(2));
      expect(todosNotifier.value.filtered[0].description, 'ghi');
      expect(todosNotifier.value.filtered[1].description, 'abc');

      todosNotifier.switchFilter(.completed);
      expect(todosNotifier.value.filtered, hasLength(1));
      expect(todosNotifier.value.filtered[0].description, 'def');
    });
  });
}
