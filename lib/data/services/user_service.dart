import 'package:dio/dio.dart';
import 'package:yumzi/core/network/dio_client.dart';
import 'package:yumzi/data/models/dto/root_entity.dart';

class UserService {
  final Dio _dio = DioClient().dio;

  final String urlPrefix = '/rest/api/user';

  Future<RootEntity> fetchUser() async {
    final response = await _dio.get('$urlPrefix/me');
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Kullanıcı bilgileri alınamadı');
    }
  }

  Future<RootEntity> updateUser(Map<String, dynamic> userData) async {
    try {
      final response = await _dio.patch('$urlPrefix/me', data: userData);
      return RootEntity.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        // Validation hatası - RootEntity olarak döndür
        return RootEntity.fromJson(e.response!.data);
      } else if (e.response != null) {
        // Diğer HTTP hataları
        return RootEntity.fromJson(e.response!.data);
      }
      throw Exception('Kullanıcı bilgileri güncellenemedi: $e');
    } catch (e) {
      throw Exception('Beklenmeyen hata: $e');
    }
  }
}
