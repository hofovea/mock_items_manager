// Project imports:
import 'package:mock_items_manager/app/feats/auth/domain/entity/user/user.dart';

abstract interface class IAuthDatasource {
  Future<List<User>> getExistingUserList();

  Future<bool> registerUser(User newUser);
}
