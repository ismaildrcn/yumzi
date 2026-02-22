import 'package:flutter/material.dart';
import 'package:yumzi/data/models/entity/cart_entity.dart';
import 'package:yumzi/data/models/entity/cart_item_entity.dart';
import 'package:yumzi/data/services/cart_service.dart';

class CartProvider extends ChangeNotifier {
  CartService service = CartService();

  bool _isLoading = false;
  String? _errorMessage;
  CartEntity? _cart;
  List<CartItemEntity> _cartItems = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  CartEntity? get cart => _cart;
  List<CartItemEntity> get cartItems => _cartItems;

  Future<CartEntity?> fetchCart() async {
    _isLoading = true;
    _errorMessage = null;

    try {
      final rootEntity = await service.fetchCartItems();

      if (rootEntity.status == 200) {
        final CartEntity cartItemsJson = CartEntity.fromJson(
          rootEntity.payload,
        );
        _cart = cartItemsJson;
        _cartItems = cartItemsJson.cartItems;
        _isLoading = false;
        return _cart!;
      } else {
        _errorMessage = 'Failed to load cart items.';
        return null;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      return null;
    }
  }

  Future<bool> addToCart({
    required String menuItemId,
    required int quantity,
  }) async {
    try {
      final request = CreateCartItemRequest(
        menuItemId: menuItemId,
        quantity: quantity,
      );
      final rootEntity = await service.addToCart(request);
      if (rootEntity.status == 200) {
        await fetchCart();
        return true;
      } else {
        _errorMessage = 'Failed to add item to cart.';
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
