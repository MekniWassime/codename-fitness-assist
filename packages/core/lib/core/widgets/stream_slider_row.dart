import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class StreamSliderRow extends StatelessWidget {
  const StreamSliderRow({
    super.key,
    this.onChanged,
    required this.id,
    required this.stream,
    this.defaultValue = 0,
    required this.label,
    required this.subtitle,
  });
  final String id;
  final Stream<double> stream;
  final double defaultValue;
  final String label;
  final String subtitle;
  final void Function(double value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, asyncSnapshot) {
        final value = switch (asyncSnapshot.connectionState) {
          ConnectionState.active => asyncSnapshot.data ?? defaultValue,
          _ => null,
        };
        return SliderRow(
          label: label,
          subtitle: subtitle,
          value: value ?? defaultValue,
          onChangeEnd: onChanged,
        );
      },
    );
  }
}
