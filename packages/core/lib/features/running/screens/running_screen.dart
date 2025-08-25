import 'package:core/core/routing/router.dart';
import 'package:core/core/sync_engine/pods/sync_client_provider.dart';
import 'package:core/features/running/entities/running_entity.dart';
import 'package:core/features/running/widgets/running_header.dart';
import 'package:core/features/running/widgets/running_item.dart';
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
    final client = ref.read(syncClientProvider);
    final entity = client.getEntity<RunningEntity>();
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
              sliver: StreamBuilder(
                stream: client.queryMany(entity),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState != ConnectionState.active) {
                    return _Loading();
                  }
                  final items = asyncSnapshot.data ?? [];
                  if (items.isEmpty) {
                    return _EmptyState();
                  }
                  return SliverList.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: RunningItem(item: item),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: DefaultTextStyle(
        style:
            TextTheme.of(
              context,
            ).headlineLarge?.copyWith(color: Theme.of(context).hintColor) ??
            TextStyle(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.apps_sharp,
              size: 64,
              color: Theme.of(context).hintColor,
            ),
            Text("No tracked run created"),
            Text("Create one now!"),
          ],
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(child: Center(child: Text("Loading")));
  }
}
