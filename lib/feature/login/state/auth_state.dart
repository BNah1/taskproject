import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<UserModel>{
  AuthenticationCubit() : super(MockData.listUserMock[0]);
}