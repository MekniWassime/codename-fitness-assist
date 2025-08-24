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
    this.min,
    this.max,
    this.showBounds,
  });
  final String id;
  final Stream<double> stream;
  final double defaultValue;
  final String label;
  final String subtitle;
  final void Function(double value)? onChanged;
  final double? min;
  final double? max;
  final bool? showBounds;

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
          max: max,
          min: min,
          showBounds: showBounds ?? false,
        );
      },
    );
  }
}
