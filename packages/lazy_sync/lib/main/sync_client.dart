import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:lazy_sync/models/sync_entity.dart';
import 'package:lazy_sync/models/sync_model.dart';
import 'package:sqflite/sqlite_api.dart';

class SyncClient {
  final UnmodifiableListView<SyncEntity> entities;
  final String serverUrl;
  final String serverUrlPrefix;
  final Database database;
  final void Function(String message) log;
  late final UnmodifiableMapView<Type, SyncEntity> entityMap =
      UnmodifiableMapView({for (final e in entities) e.runtimeType: e});
  final Map<Type, ValueNotifier<SyncModel?>> latestNotifierMap = {};

  SyncClient({
    required this.log,
    required this.serverUrl,
    required this.serverUrlPrefix,
    required this.database,
    required List<SyncEntity> entities,
  }) : entities = UnmodifiableListView(entities);

  Future<void> createDatabaseSchema() async {
    log("Starting database schema creation...");
    for (final entity in entities) {
      log("Creating ${entity.slug} table...");
      await database.execute(entity.createIfNotExistsQuery);
    }
    log("Database schema creation complete.");
  }

  T getEntity<T extends SyncEntity>() {
    assert(
      T != SyncEntity,
      'Use a concrete type of SyncEntity and not the abstract type itself',
    );
    return entityMap[T] as T;
  }

  ValueNotifier<T?>? _getLatestNotifierIfExists<T extends SyncModel>() {
    return latestNotifierMap[T] as ValueNotifier<T?>?;
  }

  ValueNotifier<T?> getLatestNotifier<T extends SyncModel>() {
    if (!latestNotifierMap.containsKey(T)) {
      latestNotifierMap[T] = ValueNotifier(null);
    }
    final notifer = latestNotifierMap[T]! as ValueNotifier<T?>;
    // fetch the latest value locally and decide to show that immediately
    // fetch latest from remote, start an async function and pass it the notifer as parameter
    return notifer;
  }
}
