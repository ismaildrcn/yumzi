import 'package:dio/dio.dart';
import 'package:yumzi/core/network/dio_client.dart';

class UserService {
  final Dio _dio = DioClient().dio;

  final String urlPrefix = '/rest/api/user';

  Future<Response> getUser() async {
    final response = await _dio.get('$urlPrefix/me');
    return response;
  }
}
