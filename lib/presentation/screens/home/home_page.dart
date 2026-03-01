import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/data/models/entity/restaurant_category_entity.dart';
import 'package:yumzi/data/models/entity/restaurant_entity.dart';
import 'package:yumzi/data/services/auth_service.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/providers/cart_provider.dart';
import 'package:yumzi/presentation/providers/restaurant_category_provider.dart';
import 'package:yumzi/presentation/providers/restaurant_providers.dart';
import 'package:yumzi/presentation/widgets/restaurant_card.dart';
import 'package:yumzi/presentation/widgets/restaurant_category_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();
  List<RestaurantCategoryEntity> categories = [];
  List<RestaurantEntity> restaurants = [];
  int cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadData() async {
    final restCategoryProvider = Provider.of<RestaurantCategoryProvider>(
      context,
      listen: false,
    );
    final restaurantProvider = Provider.of<RestaurantProviders>(
      context,
      listen: false,
    );
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cart = await cartProvider.fetchCart();
    if (cart != null && mounted) {
      cartItemCount = cart.cartItems.fold(
        0,
        (sum, item) => sum + item.quantity,
      );
    }

    final fetchedCategories = await restCategoryProvider.getCategories();
    if (fetchedCategories != null && mounted) {
      setState(() {
        categories = fetchedCategories;
      });
    }

    final fetchedRestaurants = await restaurantProvider.fetchRestaurants();
    if (fetchedRestaurants != null && mounted) {
      setState(() {
        restaurants = fetchedRestaurants;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              topBar(),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Text("Hey, Ismail 👋", style: TextStyle(fontSize: 16)),
                    Text(
                      "Good Morning",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextFormField(
                  onTap: () => context.push(AppRoutes.search.path),
                  decoration: InputDecoration(
                    hintText: 'Search dishes, restaurants',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(height: 20),
              categoriesArea(),
              SizedBox(height: 20),
              openRestaurantsArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        spacing: 20,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary.withAlpha(150),
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              onPressed: () => {context.push(AppRoutes.user.path)},
              icon: Icon(Icons.menu),
            ),
          ),
          Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DELIVER TO",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text("My Home"),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary.withAlpha(150),
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              onPressed: () => context.push(AppRoutes.cart.path),
              icon: cartItemCount > 0
                  ? Badge.count(
                      count: cartItemCount,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(200),
                      child: Icon(Icons.shopping_bag_outlined),
                    )
                  : Icon(Icons.shopping_bag_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoriesArea() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Text("All Categories", style: TextStyle(fontSize: 20)),
              Spacer(),
              TextButton(
                onPressed: () => context.push(
                  AppRoutes.restaurantCategories.path,
                  extra: categories,
                ),
                child: Row(
                  children: [
                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: SizedBox(
            height: 110,
            child: ListView.separated(
              clipBehavior: Clip.none,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 90,
                  child: RestaurantCategoryCard(category: categories[index]),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 16),
              itemCount: categories.isNotEmpty && categories.length > 8 ? 8 : 0,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ],
    );
  }

  Widget openRestaurantsArea() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Text("Open Restaurants", style: const TextStyle(fontSize: 20)),
              Spacer(),
              TextButton(
                onPressed: () => context.push(
                  AppRoutes.restaurantList.path,
                  extra: restaurants,
                ),
                child: Row(
                  children: [
                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              RestaurantCard(restaurant: restaurants[index]),
          separatorBuilder: (context, index) => SizedBox(height: 24),
          itemCount: restaurants.isNotEmpty && restaurants.length > 5 ? 5 : 0,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
