import 'package:dio/dio.dart';
import 'package:yumzi/core/network/dio_client.dart';
import 'package:yumzi/data/models/dto/root_entity.dart';

class RestaurantService {
  final Dio _dio = DioClient().dio;
  final String urlPrefix = '/rest/api/restaurant';

  Future<RootEntity> fetchRestaurants() async {
    final response = await _dio.get('$urlPrefix/all-summary');
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Restoran bilgileri alınamadı');
    }
  }

  Future<RootEntity> fetchRestaurantDetails(String restaurantId) async {
    final response = await _dio.get('$urlPrefix/$restaurantId');
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Restoran detayları alınamadı');
    }
  }

  Future<RootEntity> fetchRestaurantsByCategory(String categoryId) async {
    final response = await _dio.get(
      '$urlPrefix/list/with-category/$categoryId',
    );
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Kategoriye ait restoranlar alınamadı');
    }
  }

  Future<RootEntity> fetchMenuItems(
    String restaurantId,
    String categoryId,
  ) async {
    final response = await _dio.get(
      '$urlPrefix/$restaurantId/menu-categories/$categoryId/menu-items',
    );
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Menü öğeleri alınamadı');
    }
  }
}
