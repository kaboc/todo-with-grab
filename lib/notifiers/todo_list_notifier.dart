import 'package:flutter/widgets.dart';

import 'package:todo_with_grab/common/di.dart';

export 'package:todo_with_grab/models/todo_list.dart';

class TodoListNotifier extends ValueNotifier<TodoList> {
  TodoListNotifier() : super(const TodoList()) {
    _repository.onChange((list) => value = value.copyWith(all: list));
  }

  final _repository = todoRepositoryPot();

  final editController = TextEditingController();

  @override
  void dispose() {
    editController.dispose();
    super.dispose();
  }

  void add() {
    final todo = Todo(
      createdAt: DateTime.now(),
      description: editController.text,
    );
    _repository.add(todo);
  }

  void updateDescription(Todo todo) {
    final updatedTodo = todo.copyWith(description: editController.text);
    _repository.update(updatedTodo);
  }

  void updateCompletion(Todo todo, bool completed) {
    final updatedTodo = todo.copyWith(completed: completed);
    _repository.update(updatedTodo);
  }

  void remove(Todo todo) {
    _repository.remove(todo);
  }

  void switchFilter(TodoFilter filter) {
    value = value.copyWith(filter: filter);
  }
}
