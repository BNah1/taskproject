import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/model/user_model.dart';

class AuthService{

  Future<UserModel?> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      return MockData.listUserMock.firstWhere(
            (user) =>
        user.userLoginName == username &&
            user.passLoginName == password,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}