import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:haffez/model/user_model.dart';

import 'enums/user_type.dart';

class UserProfile {
  static final shared = UserProfile();

  late UserType userType;

  ///data in local phone storage
  UserModel? currentUser;

  final _box = GetStorage();

  Future<UserModel?> getUser() async {
    try {
      return _box.read('current-user') == ""
          ? null
          : userModelFromJson(_box.read(
              'current-user')); //from User coll get the user that = to the current user
    } catch (e) {
      return null;
    }
  }

  setUser({required UserModel? user}) async {
    try {
      if (user == null) {
        _box.remove('current-user');
        currentUser = null;
        return;
      }

      await _box.write('current-user', userModelToJson(user));
    } catch (e) {
      log(e.toString());
    }
  }
}
