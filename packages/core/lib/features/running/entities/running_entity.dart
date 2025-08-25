import 'dart:typed_data';

import 'package:core/features/running/models/intensity.dart';
import 'package:core/features/running/models/running_entry.dart';
import 'package:lazy_sync/interceptors/request_interceptor.dart';
import 'package:lazy_sync/models/sync_entity.dart';

class RunningEntity extends SyncEntity<RunningEntry, Uint8List> {
  @override
  RunningEntry deserialize(data) {
    // TODO: implement deserialize
    throw UnimplementedError();
  }

  @override
  RunningEntry fromMap(Map<String, dynamic> row) => RunningEntry(
    intensity: Intensity.values.firstWhere((i) => i.index == row["intensity"]),
    distance: row["distance"] + 0.0,
    timestamp: DateTime.fromMillisecondsSinceEpoch(row["timestamp"]),
  );

  @override
  // TODO: implement requestInterceptor
  RequestInterceptor<RunningEntry, Uint8List> get requestInterceptor =>
      throw UnimplementedError();

  @override
  serialize(RunningEntry data) {
    // TODO: implement serialize
    throw UnimplementedError();
  }

  @override
  final String slug = "running_entries";

  @override
  Map<String, dynamic> toMap(RunningEntry data) => {
    "intensity": data.intensity.index,
    "distance": data.distance,
    "timestamp": data.timestamp.millisecondsSinceEpoch,
  };

  @override
  List<String> get sqliteFields => [
    "distance NUMERIC",
    "intensity INTEGER",
    "timestamp DATETIME",
  ];
}
