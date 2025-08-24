import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'root_navigation_key_provider.g.dart';

@Riverpod(keepAlive: true)
GlobalKey<NavigatorState> rootNavigationKey(Ref ref) =>
    GlobalKey<NavigatorState>(debugLabel: 'root');
