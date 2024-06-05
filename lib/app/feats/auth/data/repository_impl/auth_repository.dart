import 'package:fpdart/fpdart.dart';
import 'package:mock_items_manager/app/feats/auth/data/datasource/i_auth_datasource.dart';
import 'package:mock_items_manager/app/feats/auth/domain/entity/user/user.dart';
import 'package:mock_items_manager/app/feats/auth/domain/repository/i_auth_repository.dart';

import 'package:mock_items_manager/core/failures/failures.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDatasource _authDatasource;

  AuthRepository({required IAuthDatasource authDatasource}) : _authDatasource = authDatasource;

  @override
  Future<Either<Failure, User>> signIn(User probeUser) async {
    try {
      final registeredUserList = await _authDatasource.getExistingUserList();
      if (registeredUserList.contains(probeUser)) {
        return Right(probeUser);
      } else {
        return Left(
          UserMissingFailure(),
        );
      }
    } on Exception {
      return Left(
        ServerInternalFailure(),
      );
    }

    // final authFactor = Random().nextDouble() * 100;
    // if (authFactor < 25) {
    // } else if (authFactor >= 25 && authFactor < 50) {
    // } else if (authFactor >= 50 && authFactor < 75) {
    // } else {}
  }

  @override
  Future<Either<Failure, User>> signUp(User probeUser) async {
    try {
      final isUserCreated = await _authDatasource.registerUser(probeUser);

      if (isUserCreated) {
        return Right(probeUser);
      } else {
        return Left(
          UserAlreadyExistsFailure(),
        );
      }
    } on Exception {
      return Left(
        ServerInternalFailure(),
      );
    }
  }
}
