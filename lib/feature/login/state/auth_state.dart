import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskproject/repository/auth_repository.dart';

import 'auth_controller_model.dart';

class AuthenticationCubit extends Cubit<AuthControllerModel>{
  AuthenticationCubit() : super(const AuthControllerModel());

  final _repository = GetIt.I<AuthRepository>();

  Future<String?> login(String userLoginName ,String passLoginName )async {
    try{
      final user = await _repository.login(userLoginName, passLoginName);
      final authControllerModel = state.copyWith(userModel: user);
      emit(authControllerModel);
      if(user != null){
        return null;
      } else {
        return "Login fail";
      }
    }
    catch(e){
      return e.toString();
    }
  }
}