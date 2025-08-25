import 'package:core/features/running/models/intensity.dart';
import 'package:core/features/running/models/running_entry.dart';
import 'package:flutter/material.dart';
import 'package:ui/widgets/card.dart';

class RunningItem extends StatelessWidget {
  const RunningItem({super.key, required this.item});

  final RunningEntry item;

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Distance: ${item.distance}km",
              style: TextTheme.of(context).labelLarge,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _IntensityIcons(level: item.intensity),
                Text(
                  item.timestamp.toString().substring(0, 10),
                  style: TextTheme.of(context).bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IntensityIcons extends StatelessWidget {
  const _IntensityIcons({required this.level});

  final Intensity level;

  @override
  Widget build(BuildContext context) {
    final index = level.index;
    final primary = Theme.of(context).primaryColor;
    final faded = Theme.of(context).disabledColor;
    return Row(
      children: [
        Icon(Icons.bolt, color: primary),
        Transform.translate(
          offset: Offset(-8, 0),
          child: Icon(Icons.bolt, color: index > 0 ? primary : faded),
        ),
        Transform.translate(
          offset: Offset(-16, 0),
          child: Icon(Icons.bolt, color: index > 1 ? primary : faded),
        ),
      ],
    );
  }
}
