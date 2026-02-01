import 'package:dio/dio.dart';
import 'package:yumzi/core/network/dio_client.dart';
import 'package:yumzi/data/models/dto/root_entity.dart';

class AddressService {
  final Dio _dio = DioClient().dio;
  final String urlPrefix = '/rest/api/address';

  Future<RootEntity> fetchAddresses() async {
    final response = await _dio.get('$urlPrefix/list');
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Adresler alınamadı');
    }
  }
}
