import 'package:flutter/material.dart';

class RunningHeader extends StatelessWidget {
  const RunningHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverResizingHeader(
      maxExtentPrototype: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: SizedBox(height: 120),
      ),
      minExtentPrototype: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: SizedBox(height: 75),
      ),
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
                        Icon(Icons.directions_walk, size: 32),
                        Text(
                          "Running",
                          style: TextTheme.of(context).titleLarge,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [Text("Total: "), Text("50km")]),
                            Row(children: [Text("Average: "), Text("50km")]),
                          ],
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
