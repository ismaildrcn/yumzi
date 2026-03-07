import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/data/models/entity/favorites_entity.dart';
import 'package:yumzi/presentation/providers/favorites_provider.dart';
import 'package:yumzi/presentation/widgets/menu_item_card.dart';
import 'package:yumzi/presentation/widgets/restaurant_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  FavoritesEntity? favorites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTopBar(context),
              const SizedBox(height: 20),
              FutureBuilder(
                future: Provider.of<FavoritesProvider>(
                  context,
                  listen: false,
                ).fetchFavorites(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final favorites = snapshot.data;
                    return buildFavorites(favorites!);
                  } else {
                    return Text('No favorites found.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFavorites(FavoritesEntity favorites) {
    return Column(
      children: [
        buildFavoriteRestaurants(favorites.favoriteRestaurants),
        SizedBox(height: 20),
        buildFavoriteMenuItems(favorites.favoriteItems),
      ],
    );
  }

  Widget buildFavoriteRestaurants(List favoriteRestaurants) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            "Restaurants",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: favoriteRestaurants.length,
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemBuilder: (context, index) {
            final restaurant = favoriteRestaurants[index];
            return RestaurantCard(restaurant: restaurant);
          },
        ),
      ],
    );
  }

  Widget buildFavoriteMenuItems(List favoriteMenuItems) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Foods",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 155 / 150,
            ),
            itemCount: favoriteMenuItems.length,
            itemBuilder: (context, index) {
              final menuItem = favoriteMenuItems[index];
              return MenuItemCard(menuItem: menuItem);
            },
          ),
        ],
      ),
    );
  }

  Widget buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary.withAlpha(150),
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              onPressed: () => {Navigator.pop(context)},
              iconSize: 28,
              icon: Icon(Icons.keyboard_arrow_left),
            ),
          ),
          SizedBox(width: 16),
          Text("Favorites", style: TextStyle(fontSize: 17)),
        ],
      ),
    );
  }
}
