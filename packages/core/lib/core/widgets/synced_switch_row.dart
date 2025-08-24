import 'package:core/core/sync_engine/pods/sync_client_provider.dart';
import 'package:core/core/widgets/stream_switch_row.dart';
import 'package:core/features/primitive_tables/entities/boolean_entity.dart';
import 'package:core/features/primitive_tables/models/boolean_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SyncedSwitchRow extends ConsumerWidget {
  const SyncedSwitchRow({
    super.key,
    required this.label,
    required this.subtitle,
    required this.id,
    this.defaultValue = false,
  });
  final String id;
  final bool defaultValue;
  final String label;
  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.read(syncClientProvider);
    final entity = client.getEntity<BooleanEntity>();
    return StreamSwitchRow(
      id: id,
      stream: client.queryOneById(id, entity).map((e) => e?.value ?? false),
      onChanged: (value) {
        client.insert(
          entity,
          BooleanEntry(timestamp: DateTime.now(), value: value, id: id),
        );
      },
      label: label,
      subtitle: subtitle,
    );
  }
}
