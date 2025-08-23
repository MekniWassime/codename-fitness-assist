import 'dart:typed_data';

import 'package:core/features/primitive_tables/models/numeric_entry.dart';
import 'package:lazy_sync/interceptors/request_interceptor.dart';
import 'package:lazy_sync/models/sync_entity.dart';

class NumericEntity extends SyncEntity<NumericEntry, Uint8List> {
  @override
  NumericEntry deserialize(data) {
    // TODO: implement deserialize
    throw UnimplementedError();
  }

  @override
  NumericEntry fromMap(Map<String, dynamic> row) => NumericEntry(
    id: row["id"],
    value: row["value"],
    timestamp: DateTime.fromMillisecondsSinceEpoch(row["timestamp"]),
  );

  @override
  // TODO: implement requestInterceptor
  RequestInterceptor<NumericEntry, Uint8List> get requestInterceptor =>
      throw UnimplementedError();

  @override
  serialize(NumericEntry data) {
    // TODO: implement serialize
    throw UnimplementedError();
  }

  @override
  final String slug = "numeric_entries";

  @override
  Map<String, dynamic> toMap(NumericEntry data) => {
    "id": data.id,
    "value": data.value,
    "timestamp": data.timestamp.millisecondsSinceEpoch,
  };

  @override
  List<String> get sqliteFields => [
    "id TEXT",
    "value NUMERIC",
    "timestamp DATETIME",
  ];
}
