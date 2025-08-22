import 'dart:async';
import 'dart:collection';

import 'package:lazy_sync/core.dart';
import 'package:lazy_sync/models/database_event.dart';
import 'package:sqflite/sqlite_api.dart';

class SyncClient {
  final UnmodifiableListView<SyncEntity> entities;
  final String serverUrl;
  final String serverUrlPrefix;
  final Database database;
  final void Function(String message) log;
  late final UnmodifiableMapView<Type, SyncEntity> entityMap =
      UnmodifiableMapView({for (final e in entities) e.runtimeType: e});
  final _databaseEventsStreamController =
      StreamController<DatabaseEvent>.broadcast();
  late final databaseEventsStream = _databaseEventsStreamController.stream;

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

  /// Insert data into the entity table
  void insert<T extends SyncModel>(
    SyncEntity<T, Object?> entity,
    T data,
  ) async {
    final raw = entity.toMap(data);
    await database.insert(entity.slug, raw);
    // Notify related queries that this entity table has been updated
    _databaseEventsStreamController.add(DatabaseInsertEvent(entity: entity));
  }

  /// Query the entity table with automatic refresh
  Stream<List<T>> query<T extends SyncModel>(
    SyncEntity<T, Object?> entity,
  ) async* {
    // read from the database and yield on listen
    final result = await database.query(entity.slug);
    yield result.map((raw) => entity.fromMap(raw)).toList();
    // refresh the query everytime an operation is perfomed on this entry
    final stream = databaseEventsStream;
    await for (final _ in stream) {
      final result = await database.query(entity.slug);
      yield result.map((raw) => entity.fromMap(raw)).toList();
    }
  }

  T getEntity<T extends SyncEntity>() {
    assert(
      T != SyncEntity,
      'Use a concrete type of SyncEntity and not the abstract type itself',
    );
    return entityMap[T] as T;
  }
}
