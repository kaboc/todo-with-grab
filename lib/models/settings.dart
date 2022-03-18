import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class Settings extends Equatable {
  const Settings({this.themeMode = ThemeMode.light});

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];

  Settings copyWith({ThemeMode? themeMode}) {
    return Settings(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final typeId = 0;

  @override
  Settings read(BinaryReader reader) {
    return Settings(
      themeMode: ThemeMode.values[reader.readInt32()],
    );
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer.writeInt32(obj.themeMode.index);
  }
}
