import 'package:flutter/foundation.dart' show ValueNotifier;

import 'package:todo_with_grab/common/_common.dart';

class TodoEditNotifier extends ValueNotifier<Todo> {
  TodoEditNotifier._({required Todo todo, required this.isNew})
    : super(todo);

  // ignore: sort_unnamed_constructors_first
  factory TodoEditNotifier({required Todo? todo}) {
    return TodoEditNotifier._(
      todo: todo ?? Todo.none(),
      isNew: todo == null,
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
