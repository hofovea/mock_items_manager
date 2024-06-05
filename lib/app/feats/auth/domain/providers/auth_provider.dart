import 'package:flutter/material.dart';
import 'package:mock_items_manager/app/feats/auth/domain/entity/user/user.dart';
import 'package:mock_items_manager/app/feats/auth/domain/repository/i_auth_repository.dart';
import 'package:mock_items_manager/core/failures/failures.dart';

class AuthProvider with ChangeNotifier {
  final IAuthRepository _authRepository;
  User? currentUser;
  String? errorMessage;

  AuthProvider({required IAuthRepository authRepository}) : _authRepository = authRepository;

  Future<void> signIn(String login, String password) async {
    final authAttempt = await _authRepository.signIn(
      User(login: login, password: password),
    );
    authAttempt.fold(
      (failure) {
        onFailure(failure);
      },
      (authorizedUser) {
        currentUser = authorizedUser;
        notifyListeners();
      },
    );
  }

  Future<void> signUp(String login, String password) async {
    final authAttempt = await _authRepository.signUp(
      User(login: login, password: password),
    );
    authAttempt.fold(
      (failure) {
        onFailure(failure);
      },
      (authorizedUser) {
        currentUser = authorizedUser;
        notifyListeners();
      },
    );
  }

  void onFailure(Failure failure) {
    errorMessage = switch (failure) {
      ServerInternalFailure() => 'Server could not process request',
      ServerUnavailableFailure() => 'Server currently not available, try later',
      InvalidResponseFailure() => 'Invalid response, try again',
      UserMissingFailure() => 'User not found, try creating account',
      UserAlreadyExistsFailure() => 'This user already exists',
    };
    notifyListeners();
  }

  void resetFailure() {
    errorMessage = null;
    notifyListeners();
  }
}
