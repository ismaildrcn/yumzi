import 'package:dio/dio.dart';

// Token suresi bittiginde veya gecerli olmadiginda
// kullaniciyi yeniden giris yapmaya yonlendirmek icin
class AuthInterceptor extends Interceptor {
  final String? Function() getToken;

  AuthInterceptor({required this.getToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}
