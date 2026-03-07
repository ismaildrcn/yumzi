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
}
