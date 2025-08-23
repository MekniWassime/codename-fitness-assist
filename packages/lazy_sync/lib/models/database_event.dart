import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lazy_sync/core.dart';

part 'database_event.freezed.dart';

abstract class DatabaseEventBase {
  SyncEntity get entity;
  String? get id;
}

@freezed
sealed class DatabaseEvent with _$DatabaseEvent implements DatabaseEventBase {
  factory DatabaseEvent.insert({required SyncEntity entity, String? id}) =
      DatabaseInsertEvent;
  factory DatabaseEvent.update({required SyncEntity entity, String? id}) =
      DatabaseUpdateEvent;
  factory DatabaseEvent.delete({required SyncEntity entity, String? id}) =
      DatabaseDeleteEvent;
}
