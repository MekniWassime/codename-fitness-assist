import 'package:core/core/sync_engine/pods/sync_client_provider.dart';
import 'package:core/features/events/entities/events_entity.dart';
import 'package:core/features/events/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/widgets/button.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final client = ref.read(syncClientProvider);
    final entity = client.getEntity<EventsEntity>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            StreamBuilder(
              stream: client.queryMany(entity),
              builder: (context, snapshot) => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = snapshot.data?[index];
                  if (item == null) return null;
                  return Text(
                    "${item.name} - ${item.timestamp.millisecondsSinceEpoch}",
                  );
                },
              ),
            ),
            MyButton(
              onPressed: () {
                final client = ref.read(syncClientProvider);
                final entity = client.getEntity<EventsEntity>();
                client.insert(
                  entity,
                  Event(name: "test", timestamp: DateTime.now()),
                );
              },
              child: Text("Button from UI package"),
            ),
            Text(
              "PLACEHOLDER",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
