import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yumzi/data/models/entity/user_entity.dart';
import 'package:yumzi/data/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  bool _isLoading = false;
  String? _errorMessage;
  Map<String, List<String>>? _validationErrors;
  UserEntity? _user;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, List<String>>? get validationErrors => _validationErrors;
  UserEntity? get user => _user;

  Future<UserEntity?> fetchUser() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userJson = await _userService.fetchUser();
      _isLoading = false;
      notifyListeners();
      _user = UserEntity.fromJson(userJson.payload!);
      return _user;
    } catch (e) {
      return null;
    }
  }

  Future<UserEntity?> updateUser(UserEntity user) async {
    _isLoading = true;
    _errorMessage = null;
    _validationErrors = null;
    notifyListeners();

    try {
      final rootEntity = await _userService.updateUser(user.toJson());
      _isLoading = false;
      notifyListeners();

      if (rootEntity.status == 200) {
        _user = UserEntity.fromJson(rootEntity.payload!);
        notifyListeners();
        return _user;
      } else if (rootEntity.status == 400) {
        final exception = rootEntity.exception!;
        final messageMap = exception.getMessageAsMap();

        if (messageMap != null) {
          // Validation errors have come as a map
          _validationErrors = messageMap.map(
            (key, value) => MapEntry(key, (value as List).cast<String>()),
          );
          _errorMessage = 'Please correct the highlighted errors.';
          notifyListeners();
        }
        return null;
      } else {
        _errorMessage = rootEntity.errorMessage ?? 'An unknown error occurred.';
        notifyListeners();
        return null;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  // Specific field error almak için
  String? getFieldError(String fieldName) {
    if (_validationErrors != null &&
        _validationErrors!.containsKey(fieldName)) {
      return _validationErrors![fieldName]!.first;
    }
    return null;
  }

  void clearErrors() {
    _errorMessage = null;
    _validationErrors = null;
    notifyListeners();
  }
}
