import 'package:core/core/widgets/synced_slider_row.dart';
import 'package:core/core/widgets/synced_switch_row.dart';
import 'package:core/features/settings/widgets/settings_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key, required this.title});
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SettingsHeader(),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8),
              sliver: SliverList.list(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: SyncedSwitchRow(
                      id: "test-swtich-1",
                      label: "Placeholder1",
                      subtitle: "Esse minim fugiat in dolor nisi ullamco.",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: SyncedSwitchRow(
                      id: "test-swtich-2",
                      label: "Placeholder2",
                      subtitle: "Esse minim fugiat in dolor nisi ullamco.",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: SyncedSwitchRow(
                      id: "test-swtich-3",
                      label: "Placeholder3",
                      subtitle: "Esse minim fugiat in dolor nisi ullamco.",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: SyncedSliderRow(
                      id: "test-slider-1",
                      label: "Placeholder4",
                      subtitle: "Id nisi dolor sint ex fugiat adipisicing.",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
