import 'package:yumzi/data/models/entity/menu_item_entity.dart';

class CartItemEntity {
  final String menuItemId;
  final int quantity;
  final double unitPrice;
  final double? discountedUnitPrice;
  final double totalPrice;

  final String? specialInstructions;
  MenuItemEntity? menuItemDetails;

  CartItemEntity({
    required this.quantity,
    required this.menuItemId,
    required this.unitPrice,
    this.discountedUnitPrice,
    required this.totalPrice,
    this.specialInstructions,
    this.menuItemDetails,
  });

  factory CartItemEntity.fromJson(Map<String, dynamic> json) {
    return CartItemEntity(
      menuItemId: json["menuItemId"],
      quantity: json["quantity"],
      unitPrice: json["unitPrice"],
      discountedUnitPrice: json["discountedUnitPrice"],
      totalPrice: json["totalPrice"],
      specialInstructions: json["specialInstructions"],
      menuItemDetails: json["menuItemDetails"] != null
          ? MenuItemEntity.fromJson(json["menuItemDetails"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "menuItemId": menuItemId,
    "quantity": quantity,
    "unitPrice": unitPrice,
    "discountedUnitPrice": discountedUnitPrice,
    "totalPrice": totalPrice,
    "specialInstructions": specialInstructions,
    "menuItemDetails": menuItemDetails?.toJson(),
  };
}

class CartItemRequest {
  final String menuItemId;
  final int quantity;
  final String? specialInstructions;

  CartItemRequest({
    required this.menuItemId,
    required this.quantity,
    this.specialInstructions,
  });

  Map<String, dynamic> toJson() => {
    "menuItemId": menuItemId,
    "quantity": quantity,
    if (specialInstructions != null) "specialInstructions": specialInstructions,
  };
}
