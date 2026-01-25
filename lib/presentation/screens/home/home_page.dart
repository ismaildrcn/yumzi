import 'package:flutter/material.dart';
import 'package:yumzi/data/models/dto/dto_login_request.dart';
import 'package:yumzi/data/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    authService.login(
      DtoLoginRequest(email: 'ismail@gmail.com', password: '1'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: const Center(child: Text('Welcome to the Home Page!')),
    );
  }
}
