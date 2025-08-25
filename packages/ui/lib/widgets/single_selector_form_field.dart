import 'package:flutter/material.dart';
import 'package:ui/widgets/single_selector.dart';

class SingleSelectorFormField<T> extends FormField<T> {
  SingleSelectorFormField({
    super.key,
    required this.label,
    required this.labelBuilder,
    required this.items,
    this.borderRadius,
    this.subtitle,
    this.controller,
    this.allowDeselect = true,
    this.onChanged,
    super.autovalidateMode,
    super.enabled,
    super.errorBuilder,
    super.forceErrorText,
    super.initialValue,
    super.onSaved,
    super.restorationId,
    super.validator,
  }) : super(
         builder: (field) {
           return SingleSelector(
             items: items,
             labelBuilder: labelBuilder,
             label: label,
             errorText: field.errorText,
             allowDeselect: allowDeselect,
             borderRadius: borderRadius,
             controller: controller,
             initialValue: initialValue,
             subtitle: subtitle,
             onChanged: (item) {
               field.didChange(item);
               onChanged?.call(item);
             },
           );
         },
       );

  final List<T> items;
  final BorderRadius? borderRadius;
  final String? subtitle;
  final String label;
  final String Function(T item) labelBuilder;
  final ValueNotifier<T?>? controller;
  final bool allowDeselect;
  final void Function(T? item)? onChanged;
}
