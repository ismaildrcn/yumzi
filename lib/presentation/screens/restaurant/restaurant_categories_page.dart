import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yumzi/data/models/entity/restaurant_category_entity.dart';
import 'package:yumzi/presentation/widgets/restaurant_category_card.dart';

class RestaurantCategoriesPage extends StatefulWidget {
  final List<RestaurantCategoryEntity> categories;
  const RestaurantCategoriesPage({super.key, required this.categories});

  @override
  State<RestaurantCategoriesPage> createState() =>
      _RestaurantCategoriesPageState();
}

class _RestaurantCategoriesPageState extends State<RestaurantCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
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
                        context.pop();
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Text("Categories", style: TextStyle(fontSize: 17)),
                ],
              ),
              SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 85 / 100,
                ),
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  return RestaurantCategoryCard(
                    category: widget.categories[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
