import 'package:dio/dio.dart';
import 'package:yumzi/core/network/dio_client.dart';
import 'package:yumzi/data/models/dto/root_entity.dart';
import 'package:yumzi/data/models/entity/cart_item_entity.dart';

class CartService {
  final Dio _dio = DioClient().dio;
  final String urlPrefix = '/rest/api/cart';

  Future<RootEntity> addToCart(CreateCartItemRequest request) async {
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
}
