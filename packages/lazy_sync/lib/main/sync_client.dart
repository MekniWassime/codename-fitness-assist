import 'dart:async';
import 'dart:collection';

import 'package:lazy_sync/core.dart';
import 'package:lazy_sync/models/database_event.dart';
import 'package:lazy_sync/models/query_options.dart';
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
    final id = data is SyncModelWithQualifier ? data.id : null;
    _databaseEventsStreamController.add(
      DatabaseInsertEvent(entity: entity, id: id),
    );
  }

  /// Query the entity table with automatic refresh
  Stream<List<T>> queryMany<T extends SyncModel>(
    SyncEntity<T, Object?> entity, [
    QueryOptions? options,
  ]) async* {
    final effectiveOptions = options ?? const QueryOptions();
    // read from the database and yield on listen
    final result = await _queryWithOptions(entity.slug, effectiveOptions);
    yield result.map((raw) => entity.fromMap(raw)).toList();
    // refresh the query everytime an operation is perfomed on this entry
    final stream = databaseEventsStream.where(
      (event) => event.entity == entity,
    );
    await for (final _ in stream) {
      final result = await _queryWithOptions(entity.slug, effectiveOptions);
      yield result.map((raw) => entity.fromMap(raw)).toList();
    }
  }

  /// Query the entity table with automatic refresh, scoped by Id
  Stream<List<T>> queryManyById<T extends SyncModel>(
    String id,
    SyncEntity<T, Object?> entity, [
    QueryOptions? options,
  ]) async* {
    final effectiveOptions = (options ?? const QueryOptions())
        .addWhereCondition("id = ?", arg: id);
    // read from the database and yield on listen
    final result = await _queryWithOptions(entity.slug, effectiveOptions);
    yield result.map((raw) => entity.fromMap(raw)).toList();
    // refresh the query everytime an operation is perfomed on this entry
    final stream = databaseEventsStream.where(
      (event) => event.entity == entity && event.id == id,
    );
    await for (final _ in stream) {
      final result = await _queryWithOptions(entity.slug, effectiveOptions);
      yield result.map((raw) => entity.fromMap(raw)).toList();
    }
  }

  /// Query one row from the entity table with automatic refresh,
  /// `options.limit` will be ignored
  ///
  /// By default, results are ordered by timestamp so you can get the latest entry
  Stream<T?> queryOne<T extends SyncModel>(
    SyncEntity<T, Object?> entity, [
    QueryOptions? options,
  ]) async* {
    final effectiveOptions = (options ?? const QueryOptions())
        .copyWith(limit: 1)
        .setOrderByIfNull("timestamp DESC");
    // read from the database and yield on listen
    final result = await _queryWithOptions(entity.slug, effectiveOptions);
    yield result.map((raw) => entity.fromMap(raw)).firstOrNull;
    // refresh the query everytime an operation is perfomed on this entry
    final stream = databaseEventsStream.where(
      (event) => event.entity == entity,
    );
    await for (final _ in stream) {
      final result = await _queryWithOptions(entity.slug, effectiveOptions);
      yield result.map((raw) => entity.fromMap(raw)).firstOrNull;
    }
  }

  /// Query one row from the entity table scoped by Id with automatic refresh,
  /// `options.limit` will be ignored
  ///
  /// By default, results are ordered by timestamp so you can get the latest entry
  Stream<T?> queryOneById<T extends SyncModelWithQualifier>(
    String id,
    SyncEntity<T, Object?> entity, [
    QueryOptions? options,
  ]) async* {
    final effectiveOptions = (options ?? const QueryOptions())
        .copyWith(limit: 1)
        .setOrderByIfNull("timestamp DESC")
        .addWhereCondition("id = ?", arg: id);
    // read from the database and yield on listen
    final result = await _queryWithOptions(entity.slug, effectiveOptions);
    yield result.map((raw) => entity.fromMap(raw)).firstOrNull;
    // refresh the query everytime an operation is perfomed on this entry
    final stream = databaseEventsStream.where(
      (event) => event.entity == entity && event.id == id,
    );
    await for (final _ in stream) {
      final result = await _queryWithOptions(entity.slug, effectiveOptions);
      yield result.map((raw) => entity.fromMap(raw)).firstOrNull;
    }
  }

  /// Perform raw sql queries on the entity table with automatic refresh
  ///
  /// Replaces `?` variable placeholder with elements from the `args` parameter
  Stream<List<Map<String, dynamic>>> queryRaw(
    SyncEntity entity,
    String query, [
    List<Object?>? args,
  ]) async* {
    final result = await database.rawQuery(query, args);
    yield result;
    final stream = databaseEventsStream.where(
      (event) => event.entity == entity,
    );
    await for (final _ in stream) {
      final result = await database.query(entity.slug);
      yield result;
    }
  }

  T getEntity<T extends SyncEntity>() {
    assert(
      T != SyncEntity,
      'Use a concrete type of SyncEntity and not the abstract type itself',
    );
    return entityMap[T] as T;
  }

  //TODO wrap the database instance with a custom class that accepts options object for query instead
  Future<List<Map<String, Object?>>> _queryWithOptions(
    String table,
    QueryOptions options,
  ) => database.query(
    table,
    distinct: options.distinct,
    limit: options.limit,
    offset: options.offset,
    orderBy: options.orderBy,
    where: options.where,
    whereArgs: options.whereArgs,
  );
}
