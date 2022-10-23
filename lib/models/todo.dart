import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

class Todo extends Equatable {
  const Todo({
    required this.description,
    required this.createdAt,
    this.completed = false,
  });

  final String description;
  final DateTime createdAt;
  final bool completed;

  @override
  List<Object> get props => [description, createdAt, completed];

  int get id => createdAt.millisecondsSinceEpoch;

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
  final typeId = 1;

  @override
  Todo read(BinaryReader reader) {
    return Todo(
      description: reader.readString(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
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
