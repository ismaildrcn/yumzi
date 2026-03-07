import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/data/models/entity/restaurant_entity.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/providers/favorites_provider.dart';
import 'package:yumzi/presentation/widgets/restaurant_meta_info.dart';

class RestaurantCard extends StatefulWidget {
  final RestaurantEntity restaurant;
  const RestaurantCard({super.key, required this.restaurant});

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.restaurant.favorite ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GestureDetector(
        onTap: () {
          context.push(
            AppRoutes.restaurant.path,
            extra: widget.restaurant.uniqueId,
          );
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
                    image: AssetImage(widget.restaurant.coverImageUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Consumer<FavoritesProvider>(
                      builder: (context, favoritesProvider, child) {
                        return GestureDetector(
                          onTap: () =>
                              onTapFavorite(context, favoritesProvider),
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
                            child: Icon(
                              isFavorite == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
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
                      widget.restaurant.name!,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 8.0),
                    RestaurantMetaInfo(restaurant: widget.restaurant),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapFavorite(BuildContext context, FavoritesProvider provider) async {
    final fav = await provider.toggleFavoriteRestaurant(
      widget.restaurant.uniqueId!,
      !isFavorite,
    );
    setState(() {
      if (fav != null) {
        isFavorite = fav;
      }
    });
  }
}
