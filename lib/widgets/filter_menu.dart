import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:todo_with_grab/common/_common.dart';

class FilterMenu extends StatelessWidget with Grab {
  const FilterMenu();

  @override
  Widget build(BuildContext context) {
    final notifier = todoListNotifierPot();
    final filter = notifier.grabAt(context, (l) => l.filter);

    final highlightStyle = context.titleMedium.copyWith(
      fontWeight: FontWeight.bold,
      color: context.primaryColor,
    );

    return PopupMenuButton<TodoFilter>(
      tooltip: 'Filter Todos',
      icon: Icon(
        Icons.filter_list,
        color: switch (filter) {
          TodoFilter.all => null,
          _ when context.isDark => context.primaryColor,
          _ => context.inversePrimaryColor,
        },
      ),
      onSelected: notifier.switchFilter,
      itemBuilder: (context) => [
        for (final f in TodoFilter.values)
          PopupMenuItem<TodoFilter>(
            value: f,
            textStyle: filter == f ? highlightStyle : null,
            child: Text(f.asSentenceCase),
          ),
      ],
    );
  }
}
