import '../../../../../app/helper/shared_helper.dart';
import '../models/user_model.dart';

abstract class BaseAuthLocalDataSource {
  Future<void> setUserData(UserModel userModel);
  Future<UserModel> getUserData();
}

class AuthLocalDataSource implements BaseAuthLocalDataSource {
  final AppShared appShared;

  AuthLocalDataSource(this.appShared);
  @override
  Future<UserModel> getUserData() async {
    var map = appShared.getVal('user');
    return UserModel.fromJson(map);
  }

  @override
  Future<void> setUserData(UserModel userModel) => appShared.setVal(
        'user',
        userModel.toJson(),
      );
}
