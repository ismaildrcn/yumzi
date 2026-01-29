import 'package:flutter/material.dart';

class RestaurantMetaInfo extends StatelessWidget {
  final double rating;
  final double deliveryFee;
  final String deliveryTime;

  const RestaurantMetaInfo({
    super.key,
    required this.rating,
    required this.deliveryFee,
    required this.deliveryTime,
  });

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
          rating.toString(),
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
          deliveryFee == 0 ? "Free" : deliveryFee.toStringAsFixed(2),
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(width: 24),
        Icon(
          Icons.access_time,
          size: 24,
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: 4),
        Text(deliveryTime, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
