import 'package:dio/dio.dart';
import 'package:yumzi/core/network/dio_client.dart';
import 'package:yumzi/data/models/dto/root_entity.dart';
import 'package:yumzi/data/models/entity/cart_item_entity.dart';

class CartService {
  final Dio _dio = DioClient().dio;
  final String urlPrefix = '/rest/api/cart';

  Future<RootEntity> addToCart(CartItemRequest request) async {
    final response = await _dio.post(
      '$urlPrefix/add-item',
      data: request.toJson(),
    );
    if (response.data["status"] != 200) {
      throw Exception('Sepete eklenemedi');
    }
    return RootEntity.fromJson(response.data);
  }

  Future<RootEntity> fetchCartItems() async {
    final response = await _dio.get('$urlPrefix/my-cart');
    if (response.data["status"] != 200) {
      throw Exception('Sepet bilgileri alınamadı');
    }
    return RootEntity.fromJson(response.data);
  }

  Future<RootEntity> removeCartItem(String cartItemId) async {
    final response = await _dio.delete('$urlPrefix/cart-items/$cartItemId');
    if (response.data["status"] != 200) {
      throw Exception('Sepet öğesi silinemedi');
    }
    return RootEntity.fromJson(response.data);
  }

  Future<RootEntity> updateCartItemQuantity(CartItemRequest request) async {
    final response = await _dio.patch(
      '$urlPrefix/update-item',
      data: request.toJson(),
    );
    if (response.data["status"] != 200) {
      throw Exception('Sepet öğesi güncellenemedi');
    }
    return RootEntity.fromJson(response.data);
  }
}
