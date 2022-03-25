import 'package:todo_with_grab/common/_common.dart';

Future<void> addTodo(String description) async {
  final notifier = todoListNotifierPot();
  notifier.editController.text = description;
  await notifier.add();
}

Future<void> addMultipleTodos(List<String> descriptions) async {
  for (final description in descriptions) {
    await addTodo(description);

    // createdAt.millisecondsSinceEpoch is used for each todo ID, meaning
    // todos are not expected to be added consecutively/simultaneously.
    // A tiny wait here ensures a different ID is assigned to each of them.
    await Future<void>.delayed(const Duration(milliseconds: 1));
  }
}
