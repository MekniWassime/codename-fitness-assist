import 'package:flutter/material.dart';

class SliderRow extends StatefulWidget {
  const SliderRow({
    super.key,
    this.borderRadius,
    this.onChangeEnd,
    this.min,
    this.max,
    this.value = 0,
    this.showBounds = false,
    this.controller,
    required this.label,
    required this.subtitle,
  });

  final String label;
  final String subtitle;
  final void Function(double value)? onChangeEnd;
  final double value;
  final BorderRadius? borderRadius;
  final double? min;
  final double? max;
  final bool showBounds;
  final ValueNotifier<double>? controller;

  @override
  State<SliderRow> createState() => _SliderRowState();
}

class _SliderRowState extends State<SliderRow> {
  late final controller =
      widget.controller ?? ValueNotifier<double>(widget.value);

  @override
  void didUpdateWidget(covariant SliderRow oldWidget) {
    controller.value = super.widget.value;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.label, style: TextTheme.of(context).titleMedium),
            Text(widget.subtitle),
            SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, child) {
                return Slider(
                  padding: EdgeInsets.zero,
                  value: value,
                  onChanged: (value) {
                    controller.value = value;
                  },
                  onChangeEnd: widget.onChangeEnd,
                  min: widget.min ?? 0,
                  max: widget.max ?? 1,
                );
              },
            ),
            if (widget.showBounds)
              Padding(
                padding: const EdgeInsets.only(left: 2, right: 2, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${(widget.min ?? 0).floor()}",
                      style: TextStyle(color: Theme.of(context).disabledColor),
                    ),
                    Text(
                      "${(widget.max ?? 1).floor()}",
                      style: TextStyle(color: Theme.of(context).disabledColor),
                    ),
                  ],
                ),
              )
            else
              SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) controller.dispose();
    super.dispose();
  }
}
