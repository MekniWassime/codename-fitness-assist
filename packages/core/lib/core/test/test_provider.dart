import 'package:core/core/pods/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'test_provider.g.dart';

@riverpod
String test(Ref ref) {
  final database = ref.watch(databaseProvider);

  return "database state is ${database.isOpen ? "open" : "closed"}";
}
