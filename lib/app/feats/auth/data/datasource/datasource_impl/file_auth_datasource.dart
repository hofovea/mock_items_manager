import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:mock_items_manager/app/feats/auth/data/datasource/i_auth_datasource.dart';
import 'package:mock_items_manager/app/feats/auth/domain/entity/user/user.dart';

class FileAuthDatasource implements IAuthDatasource {
  final File _storage;

  FileAuthDatasource({required File storage}) : _storage = storage;

  @override
  Future<List<User>> getExistingUserList() async {
    await Future.delayed(
      Duration(milliseconds: Random().nextInt(1000) + 500),
    );

    final userStorageContent = await _storage.readAsString();
    final jsonDataList = jsonDecode(userStorageContent) as List<dynamic>;
    return jsonDataList.map((jsonItem) => User.fromJson(jsonItem)).toList();
  }

  @override
  Future<bool> registerUser(User newUser) async {
    await Future.delayed(
      Duration(milliseconds: Random().nextInt(1000) + 500),
    );

    final userStorageContent = await _storage.readAsString();
    final jsonDataList = jsonDecode(userStorageContent) as List<dynamic>;
    final existingUserList = jsonDataList.map((jsonItem) => User.fromJson(jsonItem)).toList();

    if (existingUserList.firstWhereOrNull((existingUser) => existingUser.login == newUser.login) !=
        null) {
      return false;
    } else {
      existingUserList.add(newUser);
      _storage.writeAsString(
        jsonEncode(
          existingUserList.map((e) => e.toJson()).toList(),
        ),
      );
      return true;
    }
  }
}
