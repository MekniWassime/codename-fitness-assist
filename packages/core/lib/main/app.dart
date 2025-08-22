import 'package:core/core.dart';
import 'package:core/core/database/pods/database_provider.dart';
import 'package:core/features/events/models/event.dart';
import 'package:core/features/events/models/events_entity.dart';
import 'package:core/core/sync_engine/pods/sync_client_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_sync/main/sync_client.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ui/widgets/button.dart';

class MyAppCore extends StatelessWidget {
  final AppConfig _config;

  const MyAppCore({super.key, required AppConfig config}) : _config = config;

  static Future<AppConfig> getConfig({
    required String dbName,
    bool clearDatabase = false,
  }) async {
    if (kDebugMode && clearDatabase) {
      debugPrint("Clearing database...");
      await databaseFactory.deleteDatabase(dbName);
    }
    final db = await openDatabase(dbName);
    debugPrint("Database Opened");
    final syncClient = SyncClient(
      serverUrl: "placeholder",
      serverUrlPrefix: "sync-engine",
      database: db,
      log: debugPrint,
      entities: [EventsEntity()],
    );
    await syncClient.createDatabaseSchema();
    return AppConfig(database: db, syncClient: syncClient);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(_config.database),
        syncClientProvider.overrideWithValue(_config.syncClient),
      ],
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
    final client = ref.read(syncClientProvider);
    final entity = client.getEntity<EventsEntity>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            StreamBuilder(
              stream: client.query(entity),
              builder: (context, snapshot) => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = snapshot.data?[index];
                  if (item == null) return null;
                  return Text(
                    "${item.name} - ${item.timestamp.millisecondsSinceEpoch}",
                  );
                },
              ),
            ),
            MyButton(
              onPressed: () {
                final client = ref.read(syncClientProvider);
                final entity = client.getEntity<EventsEntity>();
                client.insert(
                  entity,
                  Event(name: "test", timestamp: DateTime.now()),
                );
              },
              child: Text("Button from UI package"),
            ),
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
