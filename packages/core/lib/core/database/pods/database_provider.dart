import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
Database database(Ref ref) {
  throw UnimplementedError(
    'Database must be initialized and overridden in ProviderScope',
  );
}
