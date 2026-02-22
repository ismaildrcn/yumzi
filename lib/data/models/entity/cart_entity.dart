import 'package:yumzi/data/models/entity/cart_item_entity.dart';
import 'package:yumzi/data/models/entity/restaurant_entity.dart';

class CartEntity {
  final double subTotal;
  final double deliveryFee;
  final double taxAmount;
  final double serviceFee;
  final double discountAmount;
  final double totalAmount;
  final String couponCode;
  final double couponDiscount;
  final List<CartItemEntity> cartItems;
  final RestaurantEntity restaurant;

  CartEntity({
    required this.subTotal,
    required this.deliveryFee,
    required this.taxAmount,
    required this.serviceFee,
    required this.discountAmount,
    required this.totalAmount,
    required this.couponCode,
    required this.couponDiscount,
    required this.cartItems,
    required this.restaurant,
  });

  factory CartEntity.fromJson(Map<String, dynamic> json) {
    return CartEntity(
      subTotal: json['subTotal']?.toDouble() ?? 0.0,
      deliveryFee: json['deliveryFee']?.toDouble() ?? 0.0,
      taxAmount: json['taxAmount']?.toDouble() ?? 0.0,
      serviceFee: json['serviceFee']?.toDouble() ?? 0.0,
      discountAmount: json['discountAmount']?.toDouble() ?? 0.0,
      totalAmount: json['totalAmount']?.toDouble() ?? 0.0,
      couponCode: json['couponCode'] ?? '',
      couponDiscount: json['couponDiscount']?.toDouble() ?? 0.0,
      cartItems:
          (json['cartItems'] as List<dynamic>?)
              ?.map((item) => CartItemEntity.fromJson(item))
              .toList() ??
          [],
      restaurant: RestaurantEntity.fromJson(json['restaurant']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subTotal': subTotal,
      'deliveryFee': deliveryFee,
      'taxAmount': taxAmount,
      'serviceFee': serviceFee,
      'discountAmount': discountAmount,
      'totalAmount': totalAmount,
      'couponCode': couponCode,
      'couponDiscount': couponDiscount,
      'cartItems': cartItems.map((item) => item.toJson()).toList(),
      'restaurant': restaurant.toJson(),
    };
  }
}
