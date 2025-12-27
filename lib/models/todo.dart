import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:meta/meta.dart' show useResult;

class Todo extends Equatable {
  const Todo({
    required this.description,
    required this.createdAt,
    this.completed = false,
  });

  factory Todo.none() {
    return Todo(
      description: '',
      createdAt: DateTime(0),
    );
  }

  final String description;
  final DateTime createdAt;
  final bool completed;

  @override
  List<Object> get props => [description, createdAt, completed];

  int get id => createdAt.millisecondsSinceEpoch;
  bool get isValid => description.trim().isNotEmpty;

  @useResult
  Todo copyWith({
    String? description,
    DateTime? createdAt,
    bool? completed,
  }) {
    return Todo(
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      completed: completed ?? this.completed,
    );
  }
}

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 1;

  @override
  Todo read(BinaryReader reader) {
    return Todo(
      description: reader.readString(),
      createdAt: .fromMillisecondsSinceEpoch(reader.readInt()),
      completed: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeString(obj.description)
      ..writeInt(obj.createdAt.millisecondsSinceEpoch)
      ..writeBool(obj.completed);
  }
}
