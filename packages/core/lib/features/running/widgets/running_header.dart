import 'package:core/core/sync_engine/pods/sync_client_provider.dart';
import 'package:core/features/running/entities/running_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RunningHeader extends ConsumerWidget {
  const RunningHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.read(syncClientProvider);
    final entity = client.getEntity<RunningEntity>();
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
                        StreamBuilder(
                          stream: client.queryRaw(
                            entity,
                            entity.averageAndSumRawQuery,
                          ),
                          builder: (context, asyncSnapshot) {
                            final data = asyncSnapshot.data?.firstOrNull;
                            debugPrint(data.toString());
                            final double total = (data?["total"] ?? 0) + 0.0;
                            final double average =
                                (data?["average"] ?? 0) + 0.0;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("Total: "),
                                    Text("${total.toInt()}km"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Average: "),
                                    Text("${average.ceil()}km"),
                                  ],
                                ),
                              ],
                            );
                          },
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
