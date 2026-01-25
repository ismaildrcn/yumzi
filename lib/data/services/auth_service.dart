import 'package:flutter/widgets.dart';
import 'package:yumzi/core/network/dio_client.dart';
import 'package:yumzi/core/storage/token_storage.dart';
import 'package:yumzi/data/models/dto/dto_login_request.dart';

class AuthService {
  final _dio = DioClient().dio;

  Future<void> login(DtoLoginRequest request) async {
    final response = await _dio.post('/authenticate', data: request.toJson());

    if (response.statusCode == 200) {
      debugPrint('Login successful');

      // Token'ı response'dan al ve kaydet
      final data = response.data['payload'];

      if (data is Map<String, dynamic>) {
        final accessToken =
            data['accessToken'] ?? data['access_token'] ?? data['token'];
        final refreshToken = data['refreshToken'] ?? data['refresh_token'];

        if (accessToken != null) {
          await TokenStorage.saveAccessToken(accessToken);
          debugPrint('🔑 Access token kaydedildi');

          // Kaydedildiğini doğrula
          final savedToken = await TokenStorage.getAccessToken();
          debugPrint(
            'Kaydedilen token doğrulandı: ${savedToken != null ? "${savedToken.substring(0, 20)}..." : "NULL"}',
          );
        } else {
          debugPrint('❌ accessToken null geldi!');
        }

        if (refreshToken != null) {
          await TokenStorage.saveRefreshToken(refreshToken);
          debugPrint('🔑 Refresh token kaydedildi');
        }
      }
    } else {
      debugPrint('❌ Login failed with status: ${response.statusCode}');
    }
  }

  // Logout - token'ları sil
  Future<void> logout() async {
    await TokenStorage.deleteTokens();
    debugPrint("👋 Kullanıcı çıkış yaptı, token'lar silindi");
  }

  // Token kontrolü
  Future<bool> isLoggedIn() async {
    return await TokenStorage.hasToken();
  }
}
