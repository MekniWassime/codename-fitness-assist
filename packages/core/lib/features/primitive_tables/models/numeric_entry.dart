import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lazy_sync/models/sync_model.dart';

part 'numeric_entry.freezed.dart';

@freezed
abstract class NumericEntry
    with _$NumericEntry
    implements SyncModelWithQualifier {
  factory NumericEntry({
    required DateTime timestamp,
    required num value,
    required String id,
  }) = _NumericEntry;
}
