import 'package:pot/pot.dart';

import 'package:todo_with_grab/notifiers/settings_notifier.dart';
import 'package:todo_with_grab/notifiers/todo_list_notifier.dart';
import 'package:todo_with_grab/repositories/db.dart';
import 'package:todo_with_grab/repositories/settings_repository.dart';
import 'package:todo_with_grab/repositories/todo_repository.dart';

export 'package:todo_with_grab/notifiers/settings_notifier.dart';
export 'package:todo_with_grab/notifiers/todo_list_notifier.dart';
export 'package:todo_with_grab/repositories/db.dart';
export 'package:todo_with_grab/repositories/settings_repository.dart';
export 'package:todo_with_grab/repositories/todo_repository.dart';

final dbPot = Pot(
  () => Db(),
);

final settingsRepositoryPot = Pot(
  () => SettingsRepository(),
  disposer: (repository) => repository.dispose(),
);

final todoRepositoryPot = Pot(
  () => TodoRepository(),
  disposer: (repository) => repository.dispose(),
);

final settingsNotifierPot = Pot(
  () => SettingsNotifier(),
  disposer: (notifier) => notifier.dispose(),
);

final todoListNotifierPot = Pot(
  () => TodoListNotifier(),
  disposer: (notifier) => notifier.dispose(),
);
