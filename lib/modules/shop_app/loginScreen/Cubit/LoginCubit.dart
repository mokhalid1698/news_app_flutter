import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modules.news_app/models/LoginShopAppModel/Loginmodels.dart';
import 'package:modules.news_app/modules/shop_app/loginScreen/Cubit/LoginStates.dart';

import '../../../../shared/NetWork/dio_helpper.dart';
import '../../../../shared/NetWork/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialStateLogin());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool password = true;
  IconData suffix = Icons.visibility_outlined;

  void showPassword() {
    password = !password;

    suffix =
        password ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    if (kDebugMode) {
      print(password);
    }
    emit(AppLoginShowPasswordState());
  }

  
  LoginModel? model;
  
  void getDataLogin({
    required String email,
    required String password,
  }) async {
    emit(ShopLoginLoadingState());

    await DioHelper.postData({}, "",
        url: LOGIN,
        data: {
          'email': email,
          'password': password,
        // ignore: avoid_print
        }).then((value) {
          
          
          model = LoginModel.fromJson(value.data);
          emit(ShopLoginDoneState(model!));
          if (kDebugMode) {
            print(model!.data!.name);
          }
        }).catchError((onError){

          print(onError.toString());
          emit(ShopLoginErrorState());

    });
  }
}
