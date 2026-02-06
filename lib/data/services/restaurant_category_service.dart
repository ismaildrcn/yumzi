import 'package:dio/dio.dart';
import 'package:yumzi/core/network/dio_client.dart';
import 'package:yumzi/data/models/dto/root_entity.dart';

class RestaurantCategoryService {
  final Dio _dio = DioClient().dio;
  final String urlPrefix = '/rest/api/restaurant/category';

  Future<RootEntity> fetchCategories() async {
    final response = await _dio.get('$urlPrefix/all');
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Restoran kategorileri alınamadı');
    }
  }
}
