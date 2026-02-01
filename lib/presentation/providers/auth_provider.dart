import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yumzi/data/models/dto/dto_login_request.dart';
import 'package:yumzi/data/models/dto/dto_register_request.dart';
import 'package:yumzi/data/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Register user
  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final statusCode = await _authService.register(
        DtoRegisterRequest(
          fullName: fullName,
          email: email,
          password: password,
        ).toJson(),
      );

      _isLoading = false;

      if (statusCode == HttpStatus.ok.toInt()) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Registration failed. Please try again.';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An error occurred. Please try again.';
      notifyListeners();
      return false;
    }
  }

  /// Login user
  Future<bool> login({required String email, required String password}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final statusCode = await _authService.login(
        DtoLoginRequest(email: email, password: password),
      );

      _isLoading = false;

      if (statusCode == HttpStatus.ok.toInt()) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Login failed. Please check your credentials.';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An error occurred. Please try again.';
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await _authService.logout();

    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
