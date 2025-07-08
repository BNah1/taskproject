import 'package:taskproject/model/user_model.dart';
import 'package:taskproject/service/auth_service.dart';

class AuthRepository {
  final AuthService _service;

  AuthRepository(this._service);

  Future<UserModel?> login(String username, String password) {
    return _service.login(username, password);
  }

  Future<void> logout() {
    return _service.logout();
  }
}
