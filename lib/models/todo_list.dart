import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:todo_with_grab/models/todo.dart';

export 'package:todo_with_grab/models/todo.dart';

enum TodoFilter {
  all,
  active,
  completed;

  String get asSentenceCase => name[0].toUpperCase() + name.substring(1);
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
    return switch (filter) {
      TodoFilter.all => List.of(all),
      TodoFilter.active => List.of(all.where((v) => !v.completed)),
      TodoFilter.completed => List.of(all.where((v) => v.completed)),
    };
  }

  @useResult
  TodoList copyWith({
    List<Todo>? all,
    TodoFilter? filter,
  }) {
    return TodoList(
      all: List.of(all ?? this.all),
      filter: filter ?? this.filter,
    );
  }
}
