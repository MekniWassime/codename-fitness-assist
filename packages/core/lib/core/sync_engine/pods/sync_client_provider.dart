import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_sync/main/sync_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_client_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
SyncClient syncClient(Ref ref) {
  throw UnimplementedError(
    'Database must be initialized and overridden in ProviderScope',
  );
}
