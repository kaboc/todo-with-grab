import 'package:flutter/foundation.dart' show ValueNotifier;

import 'package:todo_with_grab/common/_common.dart';

class TodoEditNotifier extends ValueNotifier<Todo> {
  TodoEditNotifier._({required Todo initialTodo, required this.isNew})
    : super(initialTodo);

  // ignore: sort_unnamed_constructors_first
  factory TodoEditNotifier({required Todo? initialTodo}) {
    return TodoEditNotifier._(
      initialTodo: initialTodo ?? Todo.none(),
      isNew: initialTodo == null,
    );
  }

  final bool isNew;

  TodosRepository get _repository => todosRepositoryPot();

  void updateDescription(String description) {
    value = value.copyWith(description: description);
  }

  Future<void> save() async {
    if (!value.isValid) {
      return;
    }

    if (isNew) {
      final todo = value.copyWith(createdAt: .now());
      await _repository.add(todo);
    } else {
      await _repository.update(value);
    }
  }
}
