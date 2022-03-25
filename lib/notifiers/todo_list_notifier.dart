import 'package:flutter/widgets.dart';

import 'package:todo_with_grab/common/di.dart';

export 'package:todo_with_grab/models/todo_list.dart';

class TodoListNotifier extends ValueNotifier<TodoList> {
  TodoListNotifier() : super(const TodoList()) {
    _repository.onChange((list) => value = value.copyWith(all: list));
  }

  final _repository = todosRepositoryPot();

  final editController = TextEditingController();

  @override
  void dispose() {
    editController.dispose();
    super.dispose();
  }

  Future<void> add() async {
    final todo = Todo(
      createdAt: DateTime.now(),
      description: editController.text,
    );
    await _repository.add(todo);
  }

  Future<void> updateDescription(Todo todo) async {
    final updatedTodo = todo.copyWith(description: editController.text);
    await _repository.update(updatedTodo);
  }

  Future<void> updateCompletion(Todo todo, bool completed) async {
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
