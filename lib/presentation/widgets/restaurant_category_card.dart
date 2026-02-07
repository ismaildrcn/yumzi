import 'package:flutter/material.dart';
import 'package:yumzi/data/models/entity/restaurant_category_entity.dart';

class RestaurantCategoryCard extends StatelessWidget {
  final RestaurantCategoryEntity category;
  const RestaurantCategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        image: AssetImage(category.iconUrl!),
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
                    category.name!,
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
    );
  }
}
