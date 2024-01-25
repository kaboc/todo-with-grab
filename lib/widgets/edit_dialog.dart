import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:todo_with_grab/common/_common.dart';

class EditDialog {
  EditDialog._();

  static void show(BuildContext context, {Todo? todo}) {
    todoListNotifierPot().editController.text = todo?.description ?? '';

    showDialog<void>(
      context: context,
      builder: (_) => _Dialog(todo, isNew: todo == null),
    );
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog(this.todo, {required this.isNew});

  final Todo? todo;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final notifier = todoListNotifierPot();
    final controller = notifier.editController;

    final isValid = controller.grabAt(context, (v) => v.text.isNotEmpty);

    return AlertDialog(
      scrollable: true,
      title: isNew ? const Text('New Todo') : null,
      content: TextField(
        controller: controller,
        autofocus: true,
        onSubmitted: isValid ? (_) => _onSubmitted(context) : null,
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: isValid ? () => _onSubmitted(context) : null,
          child: Text(isNew ? 'Add' : 'OK'),
        ),
      ],
    );
  }

  void _onSubmitted(BuildContext context) {
    final notifier = todoListNotifierPot();
    isNew ? notifier.add() : notifier.updateDescription(todo!);
    Navigator.of(context).pop();
  }
}
