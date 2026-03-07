import 'package:dio/dio.dart';
import 'package:yumzi/core/network/dio_client.dart';
import 'package:yumzi/data/models/dto/root_entity.dart';

class FavoritesService {
  final Dio _dio = DioClient().dio;
  final String urlPrefix = '/rest/api/user/favorites';

  Future<RootEntity> fetchFavorites() async {
    final response = await _dio.get(urlPrefix);
    if (response.data["status"] != 200) {
      throw Exception('Favoriler alınamadı');
    }
    return RootEntity.fromJson(response.data);
  }

  Future<RootEntity> addFavoriteMenuItem(String menuItemId) async {
    final response = await _dio.post('$urlPrefix/item/$menuItemId');
    if (response.data["status"] != 200) {
      throw Exception('Menü öğesi favorilere eklenemedi');
    }
    return RootEntity.fromJson(response.data);
  }

  Future<RootEntity> addFavoriteRestaurant(String restaurantId) async {
    final response = await _dio.post('$urlPrefix/restaurant/$restaurantId');
    if (response.data["status"] != 200) {
      throw Exception('Restoran favorilere eklenemedi');
    }
    return RootEntity.fromJson(response.data);
  }

  Future<RootEntity> removeFavoriteMenuItem(String menuItemId) async {
    final response = await _dio.delete('$urlPrefix/item/$menuItemId');
    if (response.data["status"] != 200) {
      throw Exception('Menü öğesi favorilerden kaldırılamadı');
    }
    return RootEntity.fromJson(response.data);
  }

  Future<RootEntity> removeFavoriteRestaurant(String restaurantId) async {
    final response = await _dio.delete('$urlPrefix/restaurant/$restaurantId');
    if (response.data["status"] != 200) {
      throw Exception('Restoran favorilerden kaldırılamadı');
    }
    return RootEntity.fromJson(response.data);
  }
}
