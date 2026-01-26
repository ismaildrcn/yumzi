import 'dart:ui';

import 'package:flutter/material.dart';

class AuthSkeleton extends StatefulWidget {
  final Widget title;
  final Widget body;
  final List<Widget>? decorativeIcons;
  
  const AuthSkeleton({
    super.key,
    required this.title,
    required this.body,
    this.decorativeIcons,
  });

  @override
  State<AuthSkeleton> createState() => _AuthSkeletonState();
}

class _AuthSkeletonState extends State<AuthSkeleton>
    with TickerProviderStateMixin {
  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late AnimationController _animationController3;


  @override
  void initState() {
    super.initState();
    _animationController1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _animationController3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController1.dispose();
    _animationController2.dispose();
    _animationController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Stack(
        children: [
          // Blurred animated circles
          AnimatedBuilder(
            animation: Listenable.merge([
              _animationController1,
              _animationController2,
              _animationController3,
            ]),
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    left: -50 + (_animationController1.value * 100),
                    top:
                        MediaQuery.of(context).size.height * 0.1 +
                        (_animationController1.value * 80),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(100),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -30 + (_animationController2.value * 60),
                    top:
                        MediaQuery.of(context).size.height * 0.15 +
                        (_animationController2.value * 100),
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(80),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 20,
                    top: MediaQuery.of(context).size.height * 0.06,
                    child: Transform.rotate(
                      angle: -0.4,
                      child: Icon(
                        Icons.delivery_dining,
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
                      angle: 0.4,
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 100,
                        color: Theme.of(context).colorScheme.primary.withAlpha(64),
                        shadows: [
                          Shadow(
                            blurRadius: 6,
                            color: Theme.of(context).colorScheme.primary.withAlpha(32),
                            offset: Offset(-2, -2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Title section
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            child: widget.title,
          ),

          // Body section with white container
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
              child: widget.body,
            ),
          ),
        ],
      ),
    );
  }
}
