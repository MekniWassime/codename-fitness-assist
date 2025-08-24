import 'package:core/core/routing/widgets/home_navigation.dart';
import 'package:core/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum PathRoute {
  root("/"),
  home("/home"),
  biking("/biking"),
  jogging("/jogging");

  const PathRoute(this.path);
  final String path;
}

GoRouter createRouter(GlobalKey<NavigatorState> rootNavigationKey) {
  return GoRouter(
    navigatorKey: rootNavigationKey,
    initialLocation: PathRoute.home.path,
    routes: <RouteBase>[
      GoRoute(
        path: PathRoute.root.path,
        name: PathRoute.root.name,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen(title: "test");
        },
      ),
      StatefulShellRoute.indexedStack(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              // Return the widget that implements the custom shell (in this case
              // using a BottomNavigationBar). The StatefulNavigationShell is passed
              // to be able access the state of the shell and to navigate to other
              // branches in a stateful way.
              return ScaffoldWithNavBar(navigationShell: navigationShell);
            },
        // #enddocregion configuration-builder
        // #docregion configuration-branches
        branches: <StatefulShellBranch>[
          // The route branch for the first tab of the bottom navigation bar.
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: PathRoute.jogging.path,
                name: PathRoute.jogging.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const HomeScreen(title: "Title A"),
                routes: <RouteBase>[
                  // The details screen to display stacked on navigator of the
                  // first tab. This will cover screen A but not the application
                  // shell (bottom navigation bar).
                  // GoRoute(
                  //   path: 'details',
                  //   builder: (BuildContext context, GoRouterState state) =>
                  //       const DetailsScreen(label: 'A'),
                  // ),
                ],
              ),
            ],
            // To enable preloading of the initial locations of branches, pass
            // 'true' for the parameter `preload` (false is default).
          ),
          // #enddocregion configuration-branches

          // The route branch for the second tab of the bottom navigation bar.
          StatefulShellBranch(
            // It's not necessary to provide a navigatorKey if it isn't also
            // needed elsewhere. If not provided, a default key will be used.
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the second tab of the
                // bottom navigation bar.
                path: PathRoute.home.path,
                name: PathRoute.home.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const HomeScreen(title: "Title B"),
                routes: <RouteBase>[
                  // GoRoute(
                  //   path: 'details/:param',
                  //   builder: (BuildContext context, GoRouterState state) =>
                  //       DetailsScreen(
                  //         label: 'B',
                  //         param: state.pathParameters['param'],
                  //       ),
                  // ),
                ],
              ),
            ],
          ),

          // The route branch for the third tab of the bottom navigation bar.
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the third tab of the
                // bottom navigation bar.
                path: PathRoute.biking.path,
                name: PathRoute.biking.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const HomeScreen(title: "Tilte C"),
                routes: <RouteBase>[
                  // GoRoute(
                  //   path: 'details',
                  //   builder: (BuildContext context, GoRouterState state) =>
                  //       DetailsScreen(label: 'C', extra: state.extra),
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}


      // routes: <RouteBase>[
      //   GoRoute(
      //     path: 'details',
      //     builder: (BuildContext context, GoRouterState state) {
      //       return const DetailsScreen();
      //     },
      //   ),
      // ],