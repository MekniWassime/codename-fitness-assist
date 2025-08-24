import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class StreamSwitchRow extends StatelessWidget {
  const StreamSwitchRow({
    super.key,
    this.onChanged,
    required this.id,
    required this.stream,
    this.defaultValue = false,
    required this.label,
    required this.subtitle,
  });
  final String id;
  final Stream<bool> stream;
  final bool defaultValue;
  final String label;
  final String subtitle;
  final void Function(bool value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, asyncSnapshot) {
        final value = switch (asyncSnapshot.connectionState) {
          ConnectionState.active => asyncSnapshot.data ?? defaultValue,
          _ => null,
        };
        return SwitchRow(
          label: label,
          subtitle: subtitle,
          value: value,
          onTap: () => onChanged?.call(value != null ? !value : true),
        );
      },
    );
  }
}
