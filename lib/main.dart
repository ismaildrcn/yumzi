import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/config/app_router.dart';
import 'package:yumzi/presentation/providers/auth_provider.dart';
import 'package:yumzi/styles/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp.router(
        title: 'Yumzi',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter().router,
      ),
    );
  }
}
