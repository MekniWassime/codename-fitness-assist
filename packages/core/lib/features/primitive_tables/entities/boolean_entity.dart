import 'dart:typed_data';

import 'package:core/features/primitive_tables/models/boolean_entry.dart';
import 'package:lazy_sync/interceptors/request_interceptor.dart';
import 'package:lazy_sync/models/sync_entity.dart';

class BooleanEntity extends SyncEntity<BooleanEntry, Uint8List> {
  @override
  BooleanEntry deserialize(data) {
    // TODO: implement deserialize
    throw UnimplementedError();
  }

  @override
  BooleanEntry fromMap(Map<String, dynamic> row) => BooleanEntry(
    id: row["id"],
    value: row["value"] == 1,
    timestamp: DateTime.fromMillisecondsSinceEpoch(row["timestamp"]),
  );

  @override
  // TODO: implement requestInterceptor
  RequestInterceptor<BooleanEntry, Uint8List> get requestInterceptor =>
      throw UnimplementedError();

  @override
  serialize(BooleanEntry data) {
    // TODO: implement serialize
    throw UnimplementedError();
  }

  @override
  final String slug = "numeric_entries";

  @override
  Map<String, dynamic> toMap(BooleanEntry data) => {
    "id": data.id,
    "value": data.value ? 1 : 0,
    "timestamp": data.timestamp.millisecondsSinceEpoch,
  };

  @override
  List<String> get sqliteFields => [
    "id TEXT",
    "value BOOLEAN",
    "timestamp DATETIME",
  ];
}
