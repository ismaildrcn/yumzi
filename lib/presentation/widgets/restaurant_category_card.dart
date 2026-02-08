import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/data/models/entity/restaurant_category_entity.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/providers/restaurant_providers.dart';
import 'package:yumzi/presentation/widgets/message_box.dart';

class RestaurantCategoryCard extends StatefulWidget {
  final RestaurantCategoryEntity category;
  const RestaurantCategoryCard({super.key, required this.category});

  @override
  State<RestaurantCategoryCard> createState() => _RestaurantCategoryCardState();
}

class _RestaurantCategoryCardState extends State<RestaurantCategoryCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProviders>(
      builder: (context, restaurantProvider, child) {
        return GestureDetector(
          onTap: () => _fetchRestaurants(restaurantProvider),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(32),
                        blurRadius: 12,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: -10,
                        top: -10,
                        right: 10,
                        bottom: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.category.iconUrl!),
                              fit: BoxFit.contain,
                              alignment: Alignment.topLeft,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 4,
                        right: 4,
                        child: Text(
                          widget.category.name!,
                          style: TextStyle(fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _fetchRestaurants(RestaurantProviders provider) async {
    final fetchedRestaurants = await provider.fetchRestaurantsByCategory(
      widget.category.uniqueId!,
    );
    if (fetchedRestaurants != null && mounted) {
      if (fetchedRestaurants.isEmpty) {
        MessageBox.info(
          context,
          'No restaurants were found open in this category at the moment.',
        );
        return;
      }
      context.push(AppRoutes.restaurantList.path, extra: fetchedRestaurants);
    }
  }
}
