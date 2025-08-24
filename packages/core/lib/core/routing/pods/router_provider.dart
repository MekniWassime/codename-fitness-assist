import 'package:core/core/routing/pods/root_navigation_key_provider.dart';
import 'package:core/core/routing/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final rootNavigationKey = ref.read(rootNavigationKeyProvider);
  return createRouter(rootNavigationKey);
}
