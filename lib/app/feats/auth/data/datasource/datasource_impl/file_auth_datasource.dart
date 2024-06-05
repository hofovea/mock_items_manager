// Dart imports:
import 'dart:convert';
import 'dart:math';

// Package imports:
import 'package:collection/collection.dart';

// Project imports:
import 'package:mock_items_manager/app/feats/auth/data/datasource/i_auth_datasource.dart';
import 'package:mock_items_manager/app/feats/auth/domain/entity/user/user.dart';
import 'package:mock_items_manager/core/services/file_service.dart';

class FileAuthDatasource implements IAuthDatasource {
  final FileService _storage;

  FileAuthDatasource({required FileService storage}) : _storage = storage;

  Future<void> _mockDelay() async {
    await Future.delayed(
      Duration(milliseconds: Random().nextInt(1000) + 500),
    );
  }

  @override
  Future<List<User>> getExistingUserList() async {
    await _mockDelay();

    final userStorageContent = await _storage.authStorageFile.readAsString();
    final jsonDataList = jsonDecode(userStorageContent) as List<dynamic>;
    return jsonDataList.map((jsonItem) => User.fromJson(jsonItem)).toList();
  }

  @override
  Future<bool> registerUser(User newUser) async {
    await _mockDelay();

    final userStorageContent = await _storage.authStorageFile.readAsString();
    final jsonDataList = jsonDecode(userStorageContent) as List<dynamic>;
    final existingUserList = jsonDataList.map((jsonItem) => User.fromJson(jsonItem)).toList();

    if (existingUserList.firstWhereOrNull((existingUser) => existingUser.login == newUser.login) !=
        null) {
      return false;
    } else {
      existingUserList.add(newUser);
      _storage.authStorageFile.writeAsString(
        jsonEncode(
          existingUserList.map((e) => e.toJson()).toList(),
        ),
      );
      return true;
    }
  }
}
