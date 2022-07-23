import 'package:modules.news_app/models/LoginShopAppModel/Loginmodels.dart';

abstract class LoginStates {}
class InitialStateLogin extends LoginStates {}
class AppLoginShowPasswordState extends LoginStates {}
class ShopLoginLoadingState extends LoginStates {}
class ShopLoginDoneState extends LoginStates {
  final LoginModel model ;

  ShopLoginDoneState(this.model);

}
class ShopLoginErrorState extends LoginStates {}
