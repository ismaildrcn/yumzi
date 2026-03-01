import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/core/storage/user_storage.dart';
import 'package:yumzi/data/models/entity/restaurant_category_entity.dart';
import 'package:yumzi/data/models/entity/restaurant_entity.dart';
import 'package:yumzi/data/models/entity/user_entity.dart';
import 'package:yumzi/data/services/auth_service.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/providers/address_provider.dart';
import 'package:yumzi/presentation/providers/cart_provider.dart';
import 'package:yumzi/presentation/providers/restaurant_category_provider.dart';
import 'package:yumzi/presentation/providers/restaurant_providers.dart';
import 'package:yumzi/presentation/widgets/address_selection_bottom_sheet.dart';
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
  UserEntity? user;
  String defaultAddressTitle = "Select Address";

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
    final addressProvider = Provider.of<AddressProvider>(
      context,
      listen: false,
    );
    user = await UserStorage.getUser();

    final defaultAddress = await addressProvider.fetchDefaultAddress();
    if (defaultAddress != null && mounted) {
      setState(() {
        defaultAddressTitle = defaultAddress.title;
      });
    }

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
                child: getGreeting(user?.fullName.split(" ").first ?? "Guest"),
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
          Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withAlpha(200),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 4.0,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Column(
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
                    Text(defaultAddressTitle, style: TextStyle(fontSize: 14)),
                  ],
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _showAddressSelectionBottomSheet(context),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
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

  void _showAddressSelectionBottomSheet(BuildContext context) {
    AddressSelectionBottomSheet.show(
      context,
      currentAddressTitle: defaultAddressTitle,
      onAddressSelected: (selectedTitle) {
        setState(() {
          defaultAddressTitle = selectedTitle;
        });
      },
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

  Row getGreeting(String name) {
    final hour = DateTime.now().hour;
    String greeting;

    if (hour >= 5 && hour < 12) {
      greeting = "Good Morning ☀️";
    } else if (hour >= 12 && hour < 18) {
      greeting = "Good Afternoon 🌤️";
    } else if (hour >= 18 && hour < 22) {
      greeting = "Good Evening 🌇";
    } else {
      greeting = "Good Night 🌙";
    }
    return Row(
      children: [
        Text("Hey 👋 $name, ", style: TextStyle(fontSize: 16)),
        Text(
          greeting,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
