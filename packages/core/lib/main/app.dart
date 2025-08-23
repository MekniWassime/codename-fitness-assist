import 'package:core/core.dart';
import 'package:core/core/database/pods/database_provider.dart';
import 'package:core/core/routing/pods/router_provider.dart';
import 'package:core/features/events/entities/events_entity.dart';
import 'package:core/core/sync_engine/pods/sync_client_provider.dart';
import 'package:core/features/primitive_tables/entities/numeric_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_sync/main/sync_client.dart';
import 'package:sqflite/sqflite.dart';

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
      entities: [EventsEntity(), NumericEntity()],
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
      child: _MyMaterialApp(),
    );
  }
}

class _MyMaterialApp extends ConsumerWidget {
  const _MyMaterialApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: ref.read(routerProvider),
    );
  }
}
