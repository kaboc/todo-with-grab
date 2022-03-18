import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:todo_with_grab/common/_common.dart';

class EditDialog {
  EditDialog._();

  static void show(BuildContext context, {Todo? todo}) {
    todoListNotifierPot().editController.text = todo?.description ?? '';

    showDialog<void>(
      context: context,
      builder: (_) => _Dialog(todo, todo == null),
    );
  }
}

class _Dialog extends StatelessWidget with Grab {
  const _Dialog(this.todo, this.isNew);

  final Todo? todo;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final notifier = todoListNotifierPot();
    final controller = notifier.editController;

    final isValid = context.grabAt(
      controller,
      (TextEditingValue value) => value.text.isNotEmpty,
    );

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
          child: const Text('Cancel'),
          onPressed: Navigator.of(context).pop,
        ),
        TextButton(
          child: Text(isNew ? 'Add' : 'OK'),
          onPressed: isValid ? () => _onSubmitted(context) : null,
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
