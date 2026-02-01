import 'package:flutter/material.dart';
import 'package:yumzi/data/models/entity/user_entity.dart';

class UserAvatar extends StatelessWidget {
  final UserEntity? user;
  const UserAvatar({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(150),
          child: Text(
            user != null && user!.fullName.isNotEmpty
                ? user!.fullName[0]
                : "N/A",
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
        ),
        SizedBox(width: 32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              user != null && user!.fullName.isNotEmpty
                  ? user!.fullName
                  : "N/A",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              user != null && user!.email.isNotEmpty ? user!.email : "N/A",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSecondary.withAlpha(150),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
