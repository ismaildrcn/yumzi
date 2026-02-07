import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/data/models/entity/restaurant_category_entity.dart';
import 'package:yumzi/data/services/auth_service.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/providers/restaurant_category_provider.dart';
import 'package:yumzi/presentation/widgets/restaurant_category_card.dart';
import 'package:yumzi/presentation/widgets/restaurant_meta_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();
  List<RestaurantCategoryEntity> categories = [];

  Map<String, dynamic> restaurantData = {
    "X0smic Restaurant": "assets/images/restaurant-1.jpg",
    "Yumzi Diner": "assets/images/restaurant-2.jpg",
    "Foodie's Paradise": "assets/images/restaurant-3.jpg",
  };

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
    final provider = Provider.of<RestaurantCategoryProvider>(
      context,
      listen: false,
    );
    final fetchedCategories = await provider.getCategories();
    if (fetchedCategories != null) {
      setState(() {
        categories = fetchedCategories;
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
              onPressed: () => {},
              icon: Icon(Icons.shopping_bag_outlined),
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
              Text(
                "All Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
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
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: SizedBox(
            height: 120,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return RestaurantCategoryCard(category: categories[index]);
              },
              separatorBuilder: (context, index) => SizedBox(width: 16),
              itemCount: categories.isNotEmpty ? 8 : 0,
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
              Text(
                "Open Restaurants",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
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
          itemBuilder: (context, index) => restaurantCard(
            restaurantData.keys.elementAt(index),
            restaurantData.values.elementAt(index),
          ),
          separatorBuilder: (context, index) => SizedBox(height: 30),
          itemCount: restaurantData.length,
        ),
      ],
    );
  }

  Widget restaurantCard(String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GestureDetector(
        onTap: () {
          context.push(AppRoutes.restaurant.path);
        },
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(title, style: TextStyle(fontSize: 20)),
              SizedBox(height: 16),
              RestaurantMetaInfo(
                rating: 4.5,
                deliveryFee: 0,
                deliveryTime: "30-40 min",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
