import 'package:flutter/material.dart';
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
                        Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(150),
                    ),
                    SizedBox(width: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          "Ismail Durcan",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "email@example.com",
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSecondary.withAlpha(150),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 32),

                // Menu Items
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary.withAlpha(16),
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
                        onTap: () {},
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
                    ).colorScheme.secondary.withAlpha(16),
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
                    ).colorScheme.secondary.withAlpha(16),
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
                    ).colorScheme.secondary.withAlpha(16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserMenuItem(
                        icon: Icon(Icons.logout, color: Colors.redAccent),
                        title: "Logout",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
