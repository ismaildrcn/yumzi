import 'package:flutter/material.dart';
import 'package:yumzi/data/models/entity/user_model.dart';
import 'package:yumzi/data/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<UserModel?> fetchUser() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userJson = await _userService.fetchUser();
      _isLoading = false;
      notifyListeners();
      return UserModel.fromJson(userJson.payload!);
    } catch (e) {
      return null;
    }
  }
}
