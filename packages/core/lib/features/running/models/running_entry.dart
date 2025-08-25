import 'package:core/features/running/models/intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lazy_sync/models/sync_model.dart';

part 'running_entry.freezed.dart';

@freezed
abstract class RunningEntry with _$RunningEntry implements SyncModel {
  factory RunningEntry({
    required Intensity intensity,
    required double distance,
    required DateTime timestamp,
  }) = _RunningEntry;
}
