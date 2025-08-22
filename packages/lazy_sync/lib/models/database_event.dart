import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lazy_sync/core.dart';

part 'database_event.freezed.dart';

abstract class DatabaseEventBase {
  SyncEntity get entity;
}

@freezed
sealed class DatabaseEvent with _$DatabaseEvent implements DatabaseEventBase {
  factory DatabaseEvent.insert({required SyncEntity entity}) =
      DatabaseInsertEvent;
  factory DatabaseEvent.update({required SyncEntity entity}) =
      DatabaseUpdateEvent;
  factory DatabaseEvent.delete({required SyncEntity entity}) =
      DatabaseDeleteEvent;
}
