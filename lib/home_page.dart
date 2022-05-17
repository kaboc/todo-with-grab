import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:todo_with_grab/common/_common.dart';
import 'package:todo_with_grab/widgets/_widgets.dart';

class HomePage extends StatelessWidget with Grab {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    final notifier = todoListNotifierPot();
    final list = context.grabAt(notifier, (TodoList list) => list.filtered);
    final filter = context.grabAt(notifier, (TodoList list) => list.filter);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          filter == TodoFilter.all ? 'Todo' : 'Todo - ${filter.name}',
        ),
        actions: const [
          FilterMenu(),
          SizedBox(width: 8.0),
          ThemeModeButton(),
          SizedBox(width: 8.0),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, index) => _ListTile(list[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
        onPressed: () => EditDialog.show(context),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile(this.todo);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final notifier = todoListNotifierPot();

    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => notifier.remove(todo),
      confirmDismiss: (_) => ConfirmationDialog.show(context),
      background: Container(
        color: context.theme.highlightColor,
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsetsDirectional.only(end: 16.0),
        child: Icon(
          Icons.delete,
          color: context.secondaryColor,
        ),
      ),
      child: ListTile(
        key: ValueKey(todo.id),
        title: Text(todo.description),
        leading: Checkbox(
          value: todo.completed,
          onChanged: (completed) {
            notifier.updateCompletion(todo, completed: completed!);
          },
        ),
        onTap: () => EditDialog.show(context, todo: todo),
      ),
    );
  }
}
