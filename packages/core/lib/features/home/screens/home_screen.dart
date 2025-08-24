import 'package:core/core/widgets/stream_slider_row.dart';
import 'package:core/core/widgets/synced_slider_row.dart';
import 'package:core/core/widgets/synced_switch_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/widgets/slider_row.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
      ),
    );
  }
}
