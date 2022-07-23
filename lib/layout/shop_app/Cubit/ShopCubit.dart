import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopStates.dart';
import 'package:modules.news_app/models/home_shop_app_model/HomeDataModel.dart';
import 'package:modules.news_app/modules/shop_app/CategoriesScreen/CategoriesScreen.dart';
import 'package:modules.news_app/modules/shop_app/FavoritesScreen/FavoritesScreen.dart';
import 'package:modules.news_app/modules/shop_app/ProductsScreen/ProductsScreen.dart';
import 'package:modules.news_app/modules/shop_app/SettingsScreen/SettingsScreen.dart';
import 'package:modules.news_app/shared/NetWork/end_points.dart';

import '../../../shared/NetWork/dio_helpper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void currentIndexChange(int index) {
    currentIndex = index;

    emit(ShopAppChangeCurrentIndexState());
  }

  List screensList = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  HomeModel? modelDataHome;

  void getDataHome() async {
    emit(ShopAppGetDataHomeLoadingState());
    DioHelper.getDataShop({}, token, url: HOME).then((value) {
      modelDataHome = HomeModel.fromJson(value.data);

      emit(ShopAppGetDataHomeDoneState());
      if (kDebugMode) {
        // print(modelDataHome!.data);
      }
    }).catchError((onError) {
      emit(ShopAppGetDataHomeErrorState());

      print(onError.toString() + "getDataHome");
    });
  }
}
