import 'package:equatable/equatable.dart';

import 'package:todo_with_grab/models/todo.dart';

export 'package:todo_with_grab/models/todo.dart';

enum TodoFilter {
  all,
  active,
  completed,
}

class TodoList extends Equatable {
  const TodoList({
    this.all = const [],
    this.filter = TodoFilter.all,
  });

  final List<Todo> all;
  final TodoFilter filter;

  @override
  List<Object> get props => [all, filter];

  List<Todo> get filtered {
    switch (filter) {
      case TodoFilter.all:
        return all;
      case TodoFilter.active:
        return all.where((v) => !v.completed).toList();
      case TodoFilter.completed:
        return all.where((v) => v.completed).toList();
    }
  }

  TodoList copyWith({
    List<Todo>? all,
    TodoFilter? filter,
  }) {
    return TodoList(
      all: all ?? this.all,
      filter: filter ?? this.filter,
    );
  }
}
