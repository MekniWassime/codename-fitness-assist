import 'package:core/core/sync_engine/pods/sync_client_provider.dart';
import 'package:core/core/widgets/stream_slider_row.dart';
import 'package:core/features/primitive_tables/entities/numeric_entity.dart';
import 'package:core/features/primitive_tables/models/numeric_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SyncedSliderRow extends ConsumerWidget {
  const SyncedSliderRow({
    super.key,
    required this.id,
    this.defaultValue = 0,
    required this.label,
    required this.subtitle,
  });
  final String id;
  final double defaultValue;
  final String label;
  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.read(syncClientProvider);
    final entity = client.getEntity<NumericEntity>();
    return StreamSliderRow(
      id: id,
      defaultValue: defaultValue,
      stream: client
          .queryOneById(id, entity)
          .map((e) => e?.value.toDouble() ?? 0),
      onChanged: (value) {
        client.insert(
          entity,
          NumericEntry(timestamp: DateTime.now(), value: value, id: id),
        );
      },
      label: label,
      subtitle: subtitle,
    );
  }
}
