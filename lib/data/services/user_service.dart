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
}
