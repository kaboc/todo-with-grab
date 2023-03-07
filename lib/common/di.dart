import 'package:pot/pot.dart';

import 'package:todo_with_grab/notifiers/settings_notifier.dart';
import 'package:todo_with_grab/notifiers/todo_list_notifier.dart';
import 'package:todo_with_grab/repositories/db.dart';
import 'package:todo_with_grab/repositories/settings_repository.dart';
import 'package:todo_with_grab/repositories/todos_repository.dart';

export 'package:todo_with_grab/notifiers/settings_notifier.dart';
export 'package:todo_with_grab/notifiers/todo_list_notifier.dart';
export 'package:todo_with_grab/repositories/db.dart';
export 'package:todo_with_grab/repositories/settings_repository.dart';
export 'package:todo_with_grab/repositories/todos_repository.dart';

final dbPot = Pot(
  Db.new,
  disposer: (db) => db.dispose(),
);

final settingsRepositoryPot = Pot(
  SettingsRepository.new,
  disposer: (repository) => repository.dispose(),
);

final todosRepositoryPot = Pot(
  TodosRepository.new,
  disposer: (repository) => repository.dispose(),
);

final settingsNotifierPot = Pot(
  SettingsNotifier.new,
  disposer: (notifier) => notifier.dispose(),
);

final todoListNotifierPot = Pot(
  TodoListNotifier.new,
  disposer: (notifier) => notifier.dispose(),
);
