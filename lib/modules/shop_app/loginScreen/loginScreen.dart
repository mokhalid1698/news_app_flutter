import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modules.news_app/layout/shop_app/Home_Shop_app.dart';
import 'package:modules.news_app/modules/shop_app/loginScreen/Cubit/LoginCubit.dart';
import 'package:modules.news_app/modules/shop_app/loginScreen/Cubit/LoginStates.dart';
import 'package:modules.news_app/shared/local/Shared_Preferences.dart';

import '../../../shared/defaultFormField.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is ShopLoginDoneState) {
            if (state.model.status!) {
              if (kDebugMode) {
                print(state.model.message);
              }

              CacheHelper.saveData(key: "token", value: state.model.data?.token)
                  .then((value) {
                    print(state.model.data?.token);
                    navigateTo(context, const HomeShopApp());

              });
            } else {
              FlutterToast(state.model.message!, ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          var get = LoginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Center(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: controllerEmail,
                          keyboardType: TextInputType.emailAddress,
                          enabled: true,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "please enter your email address";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Emali",
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            suffixIcon: null,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: controllerPassword,
                          keyboardType: TextInputType.visiblePassword,
                          enabled: true,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "please enter your Password";
                            }
                            return null;
                          },
                          obscureText: get.password,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(
                              Icons.vpn_key,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                get.showPassword();
                              },
                              icon: Icon(get.suffix),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              get.getDataLogin(
                                  email: controllerEmail.text,
                                  password: controllerPassword.text);
                              if (kDebugMode) {
                                print("null");
                              }
                            } else {
                              if (kDebugMode) {
                                print("hh");
                              }
                            }
                          },
                          text: "Login",
                          background: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              )),
            ),
          );
        },
      ),
    );
  }
}
