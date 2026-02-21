import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yumzi/data/models/entity/restaurant_entity.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/widgets/restaurant_meta_info.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantEntity restaurant;
  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GestureDetector(
        onTap: () {
          context.push(AppRoutes.restaurant.path, extra: restaurant.uniqueId);
        },
        child: Container(
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    image: AssetImage(restaurant.coverImageUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.topRight,
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
                        child: Icon(Icons.favorite_border, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name!,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 8.0),
                    RestaurantMetaInfo(restaurant: restaurant),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
