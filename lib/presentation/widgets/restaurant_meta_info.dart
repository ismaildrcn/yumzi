import 'package:flutter/material.dart';
import 'package:yumzi/data/models/entity/restaurant_entity.dart';

class RestaurantMetaInfo extends StatelessWidget {
  final RestaurantEntity restaurant;

  const RestaurantMetaInfo({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star_border,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
        SizedBox(width: 4),
        Text(
          restaurant.rating.toString(),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 24),
        Icon(
          Icons.delivery_dining_outlined,
          size: 24,
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: 4),
        Text(
          restaurant.deliveryFee == 0
              ? "Free"
              : restaurant.deliveryFee!.toStringAsFixed(2),
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(width: 24),
        Icon(
          Icons.access_time,
          size: 24,
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: 4),
        Text(
          restaurant.deliveryTimeRange ?? "N/A",
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
