import 'dart:async';

import 'package:hive/hive.dart';

import 'package:todo_with_grab/common/_common.dart';

class TodoRepository {
  final _box = dbPot().todoBox;

  void Function(List<Todo>)? _listener;
  StreamSubscription<BoxEvent>? _subscription;

  void dispose() {
    _subscription?.cancel();
  }

  void onChange(void Function(List<Todo>) listener) {
    _listener = listener;
    _fetchAll();

    _subscription = _box.watch().listen((_) => _fetchAll());
  }

  Future<void> _fetchAll() async {
    final list = _box.toMap().values.toList().reversed.toList();
    _listener?.call(list);
  }

  Future<void> add(Todo todo) async {
    await update(todo);
  }

  Future<void> update(Todo todo) async {
    final key = todo.id.toString();
    await _box.put(key, todo);
  }

  Future<void> remove(Todo todo) async {
    final key = todo.id.toString();
    await _box.delete(key);
  }
}
