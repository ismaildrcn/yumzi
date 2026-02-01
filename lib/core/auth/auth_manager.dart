import 'dart:io';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:yumzi/core/storage/token_storage.dart';
import 'package:yumzi/data/services/auth_service.dart';

class AuthManager {
  // Token'ın geçerli olup olmadığını kontrol et
  static Future<bool> isAuthenticated() async {
    final token = await TokenStorage.getAccessToken();

    if (token == null || token.isEmpty) {
      return false;
    }

    // Token'ın expire olup olmadığını kontrol et
    // JWT token'ı decode edip exp claim'ini kontrol edebilirsiniz
    if (await _isTokenExpired(token)) {
      // Token expire olmuşsa refresh token ile yenile
      return await _refreshToken();
    }

    return true;
  }

  // Token expire kontrolü
  static Future<bool> _isTokenExpired(String token) async {
    try {
      final decodedToken = JwtDecoder.decode(token);
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(
        decodedToken['exp'] * 1000,
      );
      return DateTime.now().isAfter(expiryDate);
    } catch (e) {
      return true; // Hata durumunda token'ı geçersiz say
    }
  }

  // Refresh token ile yeni access token al
  static Future<bool> _refreshToken() async {
    final refreshToken = await TokenStorage.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    try {
      // TODO: Burada refresh token API isteğinizi yapacaksınız
      final response = await AuthService().refreshToken(refreshToken);
      if (response == HttpStatus.ok.toInt()) {
        return true;
      }

      return false; // Şimdilik false dönüyoruz
    } catch (e) {
      await TokenStorage.deleteTokens();
      return false;
    }
  }

  // Logout
  static Future<void> logout() async {
    await TokenStorage.deleteTokens();
  }
}
