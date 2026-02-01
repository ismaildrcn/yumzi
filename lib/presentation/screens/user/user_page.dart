import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/providers/auth_provider.dart';
import 'package:yumzi/presentation/screens/user/user_avatar.dart';
import 'package:yumzi/presentation/screens/user/user_menu_item.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSecondary.withAlpha(150),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            iconSize: 28,
                            icon: Icon(Icons.chevron_left_sharp),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Text("Profile", style: TextStyle(fontSize: 17)),
                      ],
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondary.withAlpha(150),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IconButton(
                        iconSize: 28,
                        icon: Icon(Icons.more_horiz),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                UserAvatar(),

                SizedBox(height: 32),

                // Menu Items
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserMenuItem(
                        icon: Icon(
                          Icons.person_2_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: "Personel Info",
                        onTap: () => context.push(AppRoutes.userDetail.path),
                      ),
                      UserMenuItem(
                        icon: Icon(
                          Icons.pending_actions,
                          color: Colors.deepPurple,
                        ),
                        title: "Address",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserMenuItem(
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.blueAccent,
                        ),
                        title: "Cart",
                        onTap: () {},
                      ),
                      UserMenuItem(
                        icon: Icon(Icons.favorite_border, color: Colors.pink),
                        title: "Favorites",
                        onTap: () {},
                      ),
                      UserMenuItem(
                        icon: Icon(
                          Icons.notifications_outlined,
                          color: Colors.redAccent,
                        ),
                        title: "Notifications",
                        onTap: () {},
                      ),
                      UserMenuItem(
                        icon: Icon(
                          Icons.payment_outlined,
                          color: Colors.orangeAccent,
                        ),
                        title: "Payment Methods",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserMenuItem(
                        icon: Icon(
                          Icons.help_outline,
                          color: Colors.orangeAccent,
                        ),
                        title: "FAQ",
                        onTap: () {},
                      ),
                      UserMenuItem(
                        icon: Icon(
                          Icons.rate_review_outlined,
                          color: Colors.orangeAccent,
                        ),
                        title: "User Reviews",
                        onTap: () {},
                      ),
                      UserMenuItem(
                        icon: Icon(
                          Icons.settings_outlined,
                          color: Colors.deepPurpleAccent,
                        ),
                        title: "Settings",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return UserMenuItem(
                        icon: Icon(Icons.logout, color: Colors.redAccent),
                        title: "Logout",
                        onTap: () => logoutClicked(authProvider),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logoutClicked(AuthProvider authProvider) async {
    await authProvider.logout();
    if (mounted) {
      context.go(AppRoutes.login.path);
    }

    if (!mounted) return;
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(message: "You have been logged out."),
    );
  }
}
