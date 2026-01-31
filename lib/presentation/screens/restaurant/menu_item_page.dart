import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yumzi/presentation/widgets/restaurant_meta_info.dart';

class MenuItemPage extends StatefulWidget {
  const MenuItemPage({super.key});

  @override
  State<MenuItemPage> createState() => _MenuItemPageState();
}

class _MenuItemPageState extends State<MenuItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSecondary.withAlpha(150),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                              onPressed: () => {Navigator.pop(context)},
                              iconSize: 28,
                              icon: Icon(Icons.keyboard_arrow_left),
                            ),
                          ),
                          SizedBox(width: 16),
                          Text("Details", style: TextStyle(fontSize: 17)),
                        ],
                      ),
                      SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                        height: 184,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/restaurant-1.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: GestureDetector(
                              onTap: () {
                                // Handle favorite action
                              },
                              child: Container(
                                width: 38,
                                height: 38,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondary.withAlpha(150),
                                  borderRadius: BorderRadius.circular(19),
                                ),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 24),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: BoxBorder.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary.withAlpha(32),
                          ),
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).colorScheme.onSurface,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(16),
                              blurRadius: 12,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.restaurant),
                            SizedBox(width: 12),
                            Text(
                              "Italian Pizza",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cheese Pizza",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.05,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Prosciutto e funghi is a pizza variety that is topped with tomato sauce.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(
                                context,
                              ).colorScheme.secondary.withAlpha(128),
                            ),
                          ),
                          SizedBox(height: 20),
                          RestaurantMetaInfo(
                            rating: 4.5,
                            deliveryFee: 2.99,
                            deliveryTime: "30-40 min",
                          ),
                        ],
                      ),

                      SizedBox(height: 24),

                      Row(
                        children: [
                          Text(
                            "SIZE:",
                            style: TextStyle(fontSize: 14, letterSpacing: 1.05),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: HexColor("F0F5FA"),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(24),
                        blurRadius: 16,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("\$ 32.99", style: TextStyle(fontSize: 28)),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Decrease quantity action
                                  },
                                  iconSize: 20,
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.white60,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "1",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8),
                                IconButton(
                                  onPressed: () {
                                    // Increase quantity action
                                  },
                                  iconSize: 20,
                                  icon: Icon(Icons.add, color: Colors.white60),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          // Add to cart action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_bag_outlined),
                            SizedBox(width: 8),
                            Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}
