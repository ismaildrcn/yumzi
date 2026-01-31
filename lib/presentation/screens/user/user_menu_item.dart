import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserMenuItem extends StatelessWidget {
  Icon icon;
  String title;
  String? subtitle;
  VoidCallback onTap;
  UserMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: BorderRadius.circular(50),
        ),
        child: icon,
      ),
      title: Text(title, style: TextStyle(fontSize: 16)),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
