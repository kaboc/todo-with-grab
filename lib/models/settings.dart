import 'package:flutter/material.dart' show ThemeMode;

import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:meta/meta.dart';

class Settings extends Equatable {
  const Settings({this.themeMode = .system});

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];

  @useResult
  Settings copyWith({ThemeMode? themeMode}) {
    return Settings(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 0;

  @override
  Settings read(BinaryReader reader) {
    return Settings(
      themeMode: .values[reader.readInt32()],
    );
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer.writeInt32(obj.themeMode.index);
  }
}
