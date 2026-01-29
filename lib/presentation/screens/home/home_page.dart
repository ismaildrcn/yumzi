import 'package:flutter/material.dart';
import 'package:yumzi/data/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();
  Map<String, dynamic> categoryData = {
    "Burger": "assets/images/burger.png",
    "Pizza": "assets/images/pizza-1.png",
    "Sushi": "assets/images/sushi.png",
    "Dessert": "assets/images/dessert.png",
  };

  Map<String, dynamic> restaurantData = {
    "X0smic Restaurant": "assets/images/restaurant-1.jpg",
    "Yumzi Diner": "assets/images/restaurant-2.jpg",
    "Foodie's Paradise": "assets/images/restaurant-3.jpg",
  };

  @override
  void initState() {
    super.initState();
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
            child: IconButton(onPressed: () => {}, icon: Icon(Icons.menu)),
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
            height: 160,
            child: ListView.separated(
              itemBuilder: (context, index) => categoryCard(
                categoryData.keys.elementAt(index),
                categoryData.values.elementAt(index),
              ),
              separatorBuilder: (context, index) => SizedBox(width: 16),
              itemCount: categoryData.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget categoryCard(String title, String imagePath) {
    return Column(
      children: [
        Container(
          width: 122,
          height: 122,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(32),
                blurRadius: 12,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            Row(
              children: [
                Icon(
                  Icons.star_border,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                SizedBox(width: 4),
                Text(
                  "4.5",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 24),
                Icon(
                  Icons.delivery_dining_outlined,
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 4),
                Text("Free", style: TextStyle(fontSize: 14)),
                SizedBox(width: 24),
                Icon(
                  Icons.access_time,
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 4),
                Text("30-40 min", style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
