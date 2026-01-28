import 'package:flutter/material.dart';
import 'package:yumzi/presentation/screens/auth/auth_skeleton.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthSkeleton(
      title: Column(
        children: [
          Text(
            'Forgot Password',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Please sign in to your existing account',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'yumzi@example.com',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    filled: true,
                    fillColor: Theme.of(
                      context,
                    ).colorScheme.onSecondary.withAlpha(32),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSecondary.withAlpha(128),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle send code action
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 56),
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Send Code'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
