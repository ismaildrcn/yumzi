import 'package:dio/dio.dart';
import 'package:yumzi/core/network/dio_client.dart';
import 'package:yumzi/data/models/dto/root_entity.dart';

class SearchService {
  final Dio _dio = DioClient().dio;
  final String urlPrefix = '/rest/api/search';

  Future<RootEntity> autoComplete(String keyword) async {
    final response = await _dio.get(
      '$urlPrefix/auto-complete',
      queryParameters: {'keyword': keyword},
    );
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Arama sonuçları alınamadı');
    }
  }

  Future<RootEntity> recentSearches() async {
    final response = await _dio.get('$urlPrefix/recent');
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Arama sonuçları alınamadı');
    }
  }

  Future<RootEntity> search(String keyword) async {
    final response = await _dio.get(
      urlPrefix,
      queryParameters: {'keyword': keyword},
    );
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Arama sonuçları alınamadı');
    }
  }
}
