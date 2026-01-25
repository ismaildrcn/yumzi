import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:yumzi/core/network/dio_client.dart';
import 'package:yumzi/core/storage/token_storage.dart';
import 'package:yumzi/data/models/dto/dto_login_request.dart';

class AuthService {
  final _dio = DioClient().dio;

  Future<int> login(DtoLoginRequest request) async {
    try {
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
        return HttpStatus.ok;
      }
      return HttpStatus.unauthorized;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        debugPrint('❌ Login failed: Yanlış email veya şifre (401)');
        return HttpStatus.unauthorized;
      } else if (e.response?.statusCode == 500) {
        debugPrint('❌ Login failed: Server hatası (500)');
        return HttpStatus.internalServerError;
      } else {
        debugPrint(
          '❌ Login failed: ${e.response?.statusCode ?? "Bilinmeyen hata"}',
        );
        return HttpStatus.internalServerError;
      }
    } catch (ex) {
      debugPrint('❌ Login failed with unexpected error: ${ex.toString()}');
      return HttpStatus.internalServerError;
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
