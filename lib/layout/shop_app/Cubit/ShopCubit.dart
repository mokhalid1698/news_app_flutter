import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopStates.dart';
import 'package:modules.news_app/models/categoriesModel/ModelCategories.dart';
import 'package:modules.news_app/models/favoritesModel/modelFavorites.dart';
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

  Map<int, bool>? isFavorite = {};

  HomeModel? modelDataHome;

  void getDataHome() async {
    emit(ShopAppGetDataHomeLoadingState());
    DioHelper.getDataShop(
      {},
      token,
      url: HOME,
    ).then((value) {
      modelDataHome = HomeModel.fromJson(value.data);
      modelDataHome!.data!.products.forEach((element) {
        isFavorite?.addAll({
          element.id!: element.inFavorites!,
        });

        print(isFavorite![element.id]);
      });

      getDataCategories();
      emit(ShopAppGetDataHomeDoneState());
      if (kDebugMode) {
        // print(modelDataHome!.data);
      }
    }).catchError((onError) {
      emit(ShopAppGetDataHomeErrorState());

      if (kDebugMode) {
        print(onError.toString() + "getDataHome");
      }
    });
  }

  ModelCategories? modelCategories;

  void getDataCategories() async {
    emit(ShopAppGetDataCategoriesLoadingState());
    DioHelper.getDataShop(
      {},
      "",
      url: GET_CATEGORIES,
    ).then((value) {
      // print(value.data);
      modelCategories = ModelCategories.fromJson(value.data);
      // modelCategories = ModelCategories.fromJson(value.data);

      emit(ShopAppGetDataCategoriesDoneState());
      if (kDebugMode) {
        print("${modelCategories!.data!.data[0].id}");
        // print(modelDataHome!.data);
      }
    }).catchError((onError) {
      emit(ShopAppGetDataCategoriesErrorState());

      if (kDebugMode) {
        print(onError.toString() + "getDataCategories");
      }
    });
  }

  ModelFavorites? modelFavorites;
  bool? nk= true;
  void getDataChangeFavorites(int id) async {
    if (kDebugMode) {
      print(isFavorite![id].toString() + "up");
    }
    isFavorite![id] = !isFavorite![id]!;


    if (kDebugMode) {
      print(isFavorite![id]);
    }

    emit(ShopAppGetDataChangeFavoritesDoneState());

    DioHelper.postData(
      {},
      token,
      url: Favorites,
      data: {
        "product_id": id,
      },
    ).then((value) {
      // print(value.data);
      modelFavorites = ModelFavorites.fromJson(value.data);
      if (kDebugMode) {
        print(value.data);
      }
      if (!modelFavorites!.status!) {
        isFavorite![id] = !isFavorite![id]!;
        print(isFavorite![id]);
      }
      emit(ShopAppGetDataChangeFavoritesDoneState());

    }).catchError((onError) {
      isFavorite![id] = !isFavorite![id]!;

      emit(ShopAppGetDataChangeFavoritesErrorState());

      if (kDebugMode) {
        print(onError.toString() + "ChangeFavorites");
      }
    });
  }
}
