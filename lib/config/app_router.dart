import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/core/auth/auth_manager.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/providers/address_provider.dart';
import 'package:yumzi/presentation/providers/user_provider.dart';
import 'package:yumzi/presentation/screens/address/add_address_page.dart';
import 'package:yumzi/presentation/screens/address/address_page.dart';
import 'package:yumzi/presentation/screens/auth/forgot_password.dart';
import 'package:yumzi/presentation/screens/auth/login_page.dart';
import 'package:yumzi/presentation/screens/auth/register_page.dart';
import 'package:yumzi/presentation/screens/auth/verification_page.dart';
import 'package:yumzi/presentation/screens/home/home_page.dart';
import 'package:yumzi/presentation/screens/restaurant/menu_item_page.dart';
import 'package:yumzi/presentation/screens/restaurant/restaurant_page.dart';
import 'package:yumzi/presentation/screens/user/user_detail_page.dart';
import 'package:yumzi/presentation/screens/user/user_edit_page.dart';
import 'package:yumzi/presentation/screens/user/user_page.dart';

class AppRouter {
  GoRouter get router => GoRouter(
    initialLocation: AppRoutes.home.path,
    redirect: _guardRoutes,
    routes: routes,
  );

  // Route koruma mantığı
  Future<String?> _guardRoutes(
    BuildContext context,
    GoRouterState state,
  ) async {
    final isAuthenticated = await AuthManager.isAuthenticated();
    final isGoingToAuth =
        state.matchedLocation == AppRoutes.login.path ||
        state.matchedLocation == AppRoutes.register.path ||
        state.matchedLocation == AppRoutes.forgotPassword.path ||
        state.matchedLocation == AppRoutes.verification.path ||
        state.matchedLocation == AppRoutes.onboarding.path;

    // Eğer kullanıcı giriş yapmamış ve auth sayfalarına gitmiyorsa, login'e yönlendir
    if (!isAuthenticated && !isGoingToAuth) {
      return AppRoutes.login.path;
    }

    // Eğer kullanıcı giriş yapmış ve auth sayfalarına gitmeye çalışıyorsa, home'a yönlendir
    if (isAuthenticated && isGoingToAuth) {
      return AppRoutes.home.path;
    }

    // Başka bir durumda yönlendirme yapma
    return null;
  }

  List<RouteBase> get routes => [
    ShellRoute(
      builder: (context, state, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => AddressProvider()),
          ],
          child: child,
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
        GoRoute(
          name: AppRoutes.userEdit.name,
          path: AppRoutes.userEdit.path,
          builder: (context, state) => UserEditPage(),
        ),
        GoRoute(
          name: AppRoutes.address.name,
          path: AppRoutes.address.path,
          builder: (context, state) => AddressPage(),
        ),
        GoRoute(
          name: AppRoutes.addAddress.name,
          path: AppRoutes.addAddress.path,
          builder: (context, state) => AddAddressPage(),
        ),
      ],
    ),
  ];
}
