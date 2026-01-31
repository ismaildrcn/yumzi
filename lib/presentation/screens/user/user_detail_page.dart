import 'package:flutter/material.dart';
import 'package:yumzi/presentation/screens/user/user_avatar.dart';
import 'package:yumzi/presentation/screens/user/user_menu_item.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({super.key});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                          "Personal Info",
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
                        icon: Icon(Icons.edit_note_sharp),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                UserAvatar(),
                SizedBox(height: 24),

                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary.withAlpha(16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserMenuItem(
                        icon: Icon(
                          Icons.person_2_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: "Full Name",
                        subtitle: "Ismail Durcan",
                      ),
                      UserMenuItem(
                        icon: Icon(
                          Icons.email_outlined,
                          color: Colors.deepPurple,
                        ),
                        title: "Email",
                        subtitle: "ismail.durcan@example.com",
                      ),
                      UserMenuItem(
                        icon: Icon(
                          Icons.phone_outlined,
                          color: Colors.lightBlue,
                        ),
                        title: "Phone Number",
                        subtitle: "+1 234 567 890",
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
