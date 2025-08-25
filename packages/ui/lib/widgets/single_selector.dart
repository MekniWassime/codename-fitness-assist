import 'package:flutter/material.dart';
import 'package:ui/constants/constants.dart';

class SingleSelector<T> extends StatefulWidget {
  const SingleSelector({
    super.key,
    required this.items,
    this.borderRadius,
    required this.labelBuilder,
    this.subtitle,
    required this.label,
    this.allowDeselect = true,
    this.controller,
    this.onChanged,
    this.errorText,
    this.initialValue,
  });
  final List<T> items;
  final BorderRadius? borderRadius;
  final String? subtitle;
  final String label;
  final String Function(T item) labelBuilder;
  final ValueNotifier<T?>? controller;
  final bool allowDeselect;
  final void Function(T? item)? onChanged;
  final String? errorText;
  final T? initialValue;
  @override
  State<SingleSelector<T>> createState() => _SingleSelectorState<T>();
}

class _SingleSelectorState<T> extends State<SingleSelector<T>> {
  late final ValueNotifier<T?> controller =
      widget.controller ?? ValueNotifier<T?>(null);

  void _onTap(T item) {
    if (item != controller.value) {
      controller.value = item;
    } else if (widget.allowDeselect) {
      controller.value = null;
    }
    widget.onChanged?.call(controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
        color: Theme.of(context).cardColor,
      ),
      padding: EdgeInsets.all(12),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.label, style: TextTheme.of(context).titleMedium),
                if (widget.subtitle != null) Text(widget.subtitle!),
                SizedBox(height: 4),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, selectedItem, child) {
              return Row(
                children: widget.items.map((item) {
                  final selected = item == selectedItem;
                  return Expanded(
                    child: AnimatedDefaultTextStyle(
                      duration: PresetDurations.mid,
                      style:
                          (selected
                              ? Theme.of(context).primaryTextTheme.labelLarge
                              : Theme.of(context).textTheme.labelLarge) ??
                          TextStyle(),

                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap: () => _onTap(item),
                          child: AnimatedContainer(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selected
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).splashColor,
                            ),
                            duration: PresetDurations.mid,

                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                  widget.labelBuilder(item).toUpperCase(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          if (widget.errorText != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                widget.errorText!,
                style: TextTheme.of(
                  context,
                ).bodyMedium?.copyWith(color: ColorScheme.of(context).error),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) controller.dispose();
    super.dispose();
  }
}
