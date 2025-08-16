import 'package:core/core.dart';
import 'package:core/core/database/pods/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ui/widgets/button.dart';

class MyAppCore extends StatelessWidget {
  final AppConfig _config;

  const MyAppCore({super.key, required AppConfig config}) : _config = config;

  static Future<AppConfig> getConfig({required String dbName}) async {
    final db = await openDatabase(dbName);
    debugPrint("Database Opened");
    return AppConfig(database: db);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [databaseProvider.overrideWithValue(_config.database)],
      child: MyHomePage(title: "test"),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            MyButton(onPressed: () {}, child: Text("Button from UI package")),
            Text(
              "PLACEHOLDER",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
