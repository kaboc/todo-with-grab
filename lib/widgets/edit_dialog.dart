import 'package:flutter/material.dart';

import 'package:grab/grab.dart';
import 'package:pottery/pottery.dart';

import 'package:todo_with_grab/common/_common.dart';

class EditDialog {
  EditDialog._();

  static void show(BuildContext context, {Todo? todo}) {
    showDialog<void>(
      context: context,
      builder: (_) => Pottery(
        overrides: [
          todoEditNotifierPot.set(() => TodoEditNotifier(todo: todo)),
        ],
        builder: (context) {
          return const _Dialog();
        },
      ),
    );
  }
}

class _Dialog extends StatefulWidget {
  const _Dialog();

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  late final String _initialDescription =
      todoEditNotifierPot().value.description;

  @override
  Widget build(BuildContext context) {
    final notifier = todoEditNotifierPot();
    final isValid = notifier.grabAt(context, (v) => v.isValid);

    return AlertDialog(
      scrollable: true,
      title: notifier.isNew ? const Text('New Todo') : null,
      content: TextFormField(
        initialValue: _initialDescription,
        autofocus: true,
        onChanged: notifier.updateDescription,
        onEditingComplete: isValid ? () => _onSubmitted(context) : null,
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: isValid ? () => _onSubmitted(context) : null,
          child: Text(notifier.isNew ? 'Add' : 'OK'),
        ),
      ],
    );
  }

  void _onSubmitted(BuildContext context) {
    todoEditNotifierPot().save();
    Navigator.of(context).pop();
  }
}
