import 'package:taskproject/core/constant/app_enum.dart';
import 'package:taskproject/model/base_state.dart';
import 'package:taskproject/model/user_model.dart';

class AuthControllerModel extends BaseState {
  final UserModel? userModel;

  const AuthControllerModel({
    this.userModel,
    super.status,
    super.errorMessage,
  });



  AuthControllerModel copyWith({
    UserModel? userModel,
    BaseStatus? status,
    String? errorMessage,
  }) {
    return AuthControllerModel(
      userModel: userModel ?? this.userModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

}
