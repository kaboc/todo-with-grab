import 'package:flutter/foundation.dart' show ValueNotifier;

import 'package:todo_with_grab/common/_common.dart';

export 'package:todo_with_grab/models/todo_list.dart';

class TodoListNotifier extends ValueNotifier<TodoList> {
  TodoListNotifier() : super(const TodoList()) {
    _repository.onChange((list) => value = value.copyWith(all: list));
  }

  TodosRepository get _repository => todosRepositoryPot();

  Future<void> updateCompletion(Todo todo, {required bool completed}) async {
    final updatedTodo = todo.copyWith(completed: completed);
    await _repository.update(updatedTodo);
  }

  Future<void> remove(Todo todo) async {
    await _repository.remove(todo);
  }

  void switchFilter(TodoFilter filter) {
    value = value.copyWith(filter: filter);
  }
}
