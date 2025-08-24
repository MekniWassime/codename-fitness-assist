import 'package:flutter/material.dart';

class SwitchRow extends StatelessWidget {
  const SwitchRow({
    super.key,
    required this.label,
    required this.subtitle,
    required this.value,
    this.borderRadius,
    this.onTap,
  });

  final String label;
  final String subtitle;
  final bool? value;
  final BorderRadius? borderRadius;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      color: Theme.of(context).cardColor,
      child: InkWell(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        onTap: onTap,
        child: IgnorePointer(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: TextTheme.of(context).titleMedium),
                      SizedBox(height: 4),
                      Text(subtitle),
                    ],
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: value != null
                      ? Switch(
                          value: value!,
                          onChanged: onTap == null ? null : (_) {},
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
