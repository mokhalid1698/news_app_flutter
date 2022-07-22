import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/modules/shop_app/loginScreen/Cubit/LoginStates.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialStateLogin());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool password = true;
  IconData suffix = Icons.visibility_outlined;
  void showPassword() {
    password =! password;

    suffix = password ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    print(password);
    emit(AppLoginShowPasswordState());
  }
}
