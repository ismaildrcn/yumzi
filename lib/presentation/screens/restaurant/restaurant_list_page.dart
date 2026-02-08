import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yumzi/data/models/entity/restaurant_entity.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/widgets/restaurant_card.dart';

class RestaurantListPage extends StatelessWidget {
  final List<RestaurantEntity> restaurants;
  const RestaurantListPage({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondary.withAlpha(150),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: IconButton(
                          iconSize: 28,
                          icon: Icon(Icons.chevron_left_sharp),
                          onPressed: () {
                            context.push(AppRoutes.home.path);
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Text("Restaurants", style: TextStyle(fontSize: 17)),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSecondary.withAlpha(150),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () => {
                        // TODO: Implement Filter
                      },
                      icon: Icon(Icons.more_horiz),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    RestaurantCard(restaurant: restaurants[index]),
                separatorBuilder: (context, index) => SizedBox(height: 24),
                itemCount: restaurants.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
