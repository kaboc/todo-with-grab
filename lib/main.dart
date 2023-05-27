import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:todo_with_grab/common/_common.dart';
import 'package:todo_with_grab/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbPot().init();

  runApp(const App());
}

class App extends StatelessWidget with Grab {
  const App();

  @override
  Widget build(BuildContext context) {
    final notifier = settingsNotifierPot();
    final themeMode = notifier.grabAt(context, (s) => s.themeMode);

    return MaterialApp(
      title: 'Todo',
      themeMode: themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const HomePage(),
    );
  }
}
