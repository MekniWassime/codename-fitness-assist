import 'package:core/core/routing/router.dart';
import 'package:core/core/widgets/synced_switch_row.dart';
import 'package:core/features/running/widgets/running_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RunningScreen extends ConsumerStatefulWidget {
  const RunningScreen({super.key, required this.title});
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RunningScreenState();
}

class _RunningScreenState extends ConsumerState<RunningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          context.pushNamed(PathRoute.joggingCreate.name);
        },
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            RunningHeader(),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8),
              sliver: SliverList.builder(
                itemCount: 20,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: SyncedSwitchRow(
                    label: "label",
                    subtitle: "subtitle",
                    id: "id$index",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
