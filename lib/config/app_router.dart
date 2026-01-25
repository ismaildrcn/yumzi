import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yumzi/enums/app_routes.dart';

class AppRouter {
  GoRouter get router => GoRouter(
    // refreshListenable: authProvider,
    // redirect: _guardRoutes,
    routes: routes,
  );

  List<RouteBase> get routes => [
    ShellRoute(
      builder: (context, state, child) {
        // final hideBottomNavigation = [AppRoutes.onboarding.path];

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          // bottomNavigationBar: hideBottomNavigation.contains(state.uri.path)
          //     ? null
          //     : CustomBottomNavigationBar(state: state),
          body: child,
        );
      },
      routes: [
        GoRoute(
          name: AppRoutes.onboarding.name,
          path: AppRoutes.onboarding.path,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Onboarding Screen'))),
        ),
        GoRoute(
          name: AppRoutes.home.name,
          path: AppRoutes.home.path,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Home Screen'))),
        ),
      ],
    ),
  ];
}
