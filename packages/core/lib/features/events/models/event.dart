import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lazy_sync/models/sync_model.dart';

part 'event.freezed.dart';

@freezed
abstract class Event with _$Event implements SyncModel {
  factory Event({required String name, required DateTime timestamp}) = _Event;
}
