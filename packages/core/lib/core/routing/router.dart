import 'package:core/core/routing/widgets/home_navigation.dart';
import 'package:core/core/routing/widgets/modal_bottom_sheet_page.dart';
import 'package:core/features/settings/screens/settings_screen.dart';
import 'package:core/features/running/screens/running_create_screen.dart';
import 'package:core/features/running/screens/running_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum PathRoute {
  root("/"),
  settings("/settings"),
  jogging("/jogging"),
  joggingCreate("/jogging/create");

  const PathRoute(this.path);
  final String path;
}

GoRouter createRouter(GlobalKey<NavigatorState> rootNavigationKey) {
  return GoRouter(
    navigatorKey: rootNavigationKey,
    initialLocation: PathRoute.jogging.path,
    routes: <RouteBase>[
      GoRoute(
        path: PathRoute.root.path,
        name: PathRoute.root.name,
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsScreen(title: "test");
        },
      ),
      StatefulShellRoute.indexedStack(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) => ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: PathRoute.jogging.path,
                name: PathRoute.jogging.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const RunningScreen(title: "Running"),
                routes: <RouteBase>[
                  GoRoute(
                    path: PathRoute.joggingCreate.path,
                    name: PathRoute.joggingCreate.name,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        ModalBottomSheetPage(
                          isScrollControlled: true,
                          enableDrag: true,
                          builder: (context) =>
                              CreateRunningScreen(title: "test"),
                        ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: PathRoute.settings.path,
                name: PathRoute.settings.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const SettingsScreen(title: "Title B"),
                routes: <RouteBase>[],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
