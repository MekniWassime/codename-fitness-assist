import 'dart:typed_data';

import 'package:core/features/events/models/event.dart';
import 'package:lazy_sync/interceptors/request_interceptor.dart';
import 'package:lazy_sync/models/sync_entity.dart';

class EventsEntity extends SyncEntity<Event, Uint8List> {
  @override
  Event deserialize(data) {
    // TODO: implement deserialize
    throw UnimplementedError();
  }

  @override
  Event fromMap(Map<String, dynamic> row) => Event(
    name: row["name"],
    timestamp: DateTime.fromMillisecondsSinceEpoch(row["timestamp"]),
  );

  @override
  // TODO: implement requestInterceptor
  RequestInterceptor<Event, Uint8List> get requestInterceptor =>
      throw UnimplementedError();

  @override
  serialize(Event data) {
    // TODO: implement serialize
    throw UnimplementedError();
  }

  @override
  final String slug = "events";

  @override
  Map<String, dynamic> toMap(Event data) => {
    "name": data.name,
    "timestamp": data.timestamp.millisecondsSinceEpoch,
  };

  @override
  List<String> get sqliteFields => ["name TEXT", "timestamp DATETIME"];
}
