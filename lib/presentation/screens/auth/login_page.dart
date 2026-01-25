import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Stack(
        children: [
          Positioned(
            left: 20,
            top: MediaQuery.of(context).size.height * 0.06,
            child: Transform.rotate(
              angle:
                  -0.4, // Radyan cinsinden açı (negatif = saat yönünün tersine)
              child: Icon(
                Icons.fastfood,
                size: 120,
                color: Theme.of(context).colorScheme.primary.withAlpha(64),
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Theme.of(context).colorScheme.primary.withAlpha(32),
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 20,
            top: MediaQuery.of(context).size.height * 0.26,
            child: Transform.rotate(
              angle:
                  0.4, // Radyan cinsinden açı (negatif = saat yönünün tersine)
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 100,
                color: Theme.of(context).colorScheme.primary.withAlpha(64),
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Theme.of(context).colorScheme.primary.withAlpha(32),
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                Text(
                  'Please sign in to your existing account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.65,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.color,
                          ),
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'example@example.com',
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
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.color,
                          ),
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (newValue) {
                                setState(() {
                                  rememberMe = newValue!;
                                });
                              },
                            ),
                            Text(
                              'Remember Me',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(
                                  context,
                                ).textTheme.labelLarge!.color,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                // Forgot password action
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Giriş işlemi
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          MediaQuery.of(context).size.width,
                          56,
                        ),
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Log In'),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.color,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Kayıt olma sayfasına yönlendirme
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
