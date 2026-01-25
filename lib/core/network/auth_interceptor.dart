import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:yumzi/core/storage/token_storage.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // Token'ı storage'dan al
      final token = await TokenStorage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        // Token varsa Authorization header'ına ekle
        options.headers['Authorization'] = 'Bearer $token';
      } else {
        debugPrint('[AUTH_INTERCEPTOR] Token bulunamadı veya boş');
      }

      // İsteği devam ettir
      handler.next(options);
    } catch (e) {
      debugPrint('[AUTH_INTERCEPTOR] Token alma hatası: $e');
      handler.next(options);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('[AUTH_INTERCEPTOR] Error: ${err.response?.statusCode}');

    // 401 Unauthorized - Token geçersiz veya süresi dolmuş
    if (err.response?.statusCode == 401) {
      debugPrint(
        '[AUTH_INTERCEPTOR] 401 - Token geçersiz, kullanıcı çıkış yapmalı',
      );
      // Burada token refresh veya logout işlemi yapılabilir
      await TokenStorage.deleteTokens();
    }

    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('[AUTH_INTERCEPTOR] Response: ${response.statusCode}');
    handler.next(response);
  }
}
