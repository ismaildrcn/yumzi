import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yumzi/data/models/entity/user_entity.dart';

class UserStorage {
  static const _storage = FlutterSecureStorage();
  static const _userKey = 'user';

  static Future<void> saveUser(UserEntity userData) async {
    await _storage.write(key: _userKey, value: jsonEncode(userData.toJson()));
  }

  static Future<UserEntity?> getUser() async {
    final userJson = await _storage.read(key: _userKey);
    if (userJson != null) {
      final Map<String, dynamic> userMap = Map<String, dynamic>.from(
        jsonDecode(userJson),
      );
      return UserEntity.fromJson(userMap);
    }
    return null;
  }

  static Future<UserEntity> updateUser(UserEntity updatedUser) async {
    await saveUser(updatedUser);
    return updatedUser;
  }

  static Future<void> deleteUser() async {
    await _storage.delete(key: _userKey);
  }
}
