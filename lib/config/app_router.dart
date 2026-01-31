import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/screens/auth/forgot_password.dart';
import 'package:yumzi/presentation/screens/auth/login_page.dart';
import 'package:yumzi/presentation/screens/auth/register_page.dart';
import 'package:yumzi/presentation/screens/auth/verification_page.dart';
import 'package:yumzi/presentation/screens/home/home_page.dart';
import 'package:yumzi/presentation/screens/restaurant/menu_item_page.dart';
import 'package:yumzi/presentation/screens/restaurant/restaurant_page.dart';
import 'package:yumzi/presentation/screens/user/user_detail_page.dart';
import 'package:yumzi/presentation/screens/user/user_page.dart';

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
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          name: AppRoutes.login.name,
          path: AppRoutes.login.path,
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          name: AppRoutes.register.name,
          path: AppRoutes.register.path,
          builder: (context, state) => RegisterPage(),
        ),
        GoRoute(
          name: AppRoutes.verification.name,
          path: AppRoutes.verification.path,
          builder: (context, state) => VerificationPage(),
        ),
        GoRoute(
          name: AppRoutes.forgotPassword.name,
          path: AppRoutes.forgotPassword.path,
          builder: (context, state) => ForgotPasswordPage(),
        ),
        GoRoute(
          name: AppRoutes.restaurant.name,
          path: AppRoutes.restaurant.path,
          builder: (context, state) => RestaurantPage(),
        ),
        GoRoute(
          name: AppRoutes.menuItem.name,
          path: AppRoutes.menuItem.path,
          builder: (context, state) => MenuItemPage(),
        ),
        GoRoute(
          name: AppRoutes.user.name,
          path: AppRoutes.user.path,
          builder: (context, state) => UserPage(),
        ),
        GoRoute(
          name: AppRoutes.userDetail.name,
          path: AppRoutes.userDetail.path,
          builder: (context, state) => UserDetailPage(),
        ),
      ],
    ),
  ];
}
