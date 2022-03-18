import 'package:flutter/material.dart';

class ConfirmationDialog {
  ConfirmationDialog._();

  static Future<bool> show(BuildContext context) async {
    final delete = await showDialog<bool>(
      context: context,
      builder: (_) => const _Dialog(),
    );
    return delete ?? false;
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: const Text('Are you sure you want to remove it?'),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: const Text('Remove'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
