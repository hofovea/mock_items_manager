// Package imports:
import 'package:fpdart/fpdart.dart';

// Project imports:
import 'package:mock_items_manager/app/feats/auth/domain/entity/user/user.dart';
import 'package:mock_items_manager/core/failures/failures.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, User>> signIn(User probeUser);

  Future<Either<Failure, User>> signUp(User probeUser);
}
