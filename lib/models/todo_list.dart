import 'package:equatable/equatable.dart';

import 'package:todo_with_grab/models/todo.dart';

export 'package:todo_with_grab/models/todo.dart';

enum TodoFilter {
  all,
  active,
  completed;

  List<Todo> apply(List<Todo> list) {
    switch (this) {
      case TodoFilter.all:
        return list;
      case TodoFilter.active:
        return list.where((v) => !v.completed).toList();
      case TodoFilter.completed:
        return list.where((v) => v.completed).toList();
    }
  }
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

  List<Todo> get filtered => filter.apply(all);

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
