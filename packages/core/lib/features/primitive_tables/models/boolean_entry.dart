import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lazy_sync/models/sync_model.dart';

part 'boolean_entry.freezed.dart';

@freezed
abstract class BooleanEntry
    with _$BooleanEntry
    implements SyncModelWithQualifier {
  factory BooleanEntry({
    required DateTime timestamp,
    required bool value,
    required String id,
  }) = _BooleanEntry;
}
