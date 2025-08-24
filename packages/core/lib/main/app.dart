import 'package:core/core.dart';
import 'package:core/core/database/pods/database_provider.dart';
import 'package:core/core/routing/pods/router_provider.dart';
import 'package:core/features/events/entities/events_entity.dart';
import 'package:core/core/sync_engine/pods/sync_client_provider.dart';
import 'package:core/features/primitive_tables/entities/boolean_entity.dart';
import 'package:core/features/primitive_tables/entities/numeric_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_sync/main/sync_client.dart';
import 'package:sqflite/sqflite.dart';

class MyAppCore extends StatefulWidget {
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
      entities: [EventsEntity(), NumericEntity(), BooleanEntity()],
    );
    await syncClient.createDatabaseSchema();
    return AppConfig(database: db, syncClient: syncClient);
  }

  @override
  State<MyAppCore> createState() => _MyAppCoreState();
}

class _MyAppCoreState extends State<MyAppCore> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(widget._config.database),
        syncClientProvider.overrideWithValue(widget._config.syncClient),
      ],
      child: _MyMaterialApp(),
    );
  }
}

class _MyMaterialApp extends ConsumerStatefulWidget {
  const _MyMaterialApp();

  @override
  ConsumerState<_MyMaterialApp> createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends ConsumerState<_MyMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 0, 255, 213),
        ),
        sliderTheme: SliderThemeData(trackHeight: 24),
        scaffoldBackgroundColor: Color.fromARGB(255, 233, 237, 242),
        cardColor: Color(0xffffffff),
      ),
      routerConfig: ref.read(routerProvider),
    );
  }
}
