import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return PinnedHeaderSliver(
      child: Material(
        elevation: 1,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  SizedBox(
                    height: 43,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 32,
                          child: Icon(Icons.settings, size: 26),
                        ),
                        Text(
                          "Settings",
                          style: TextTheme.of(context).titleLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
