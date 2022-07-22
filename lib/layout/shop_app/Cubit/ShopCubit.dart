import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopStates.dart';
import 'package:modules.news_app/modules/shop_app/CategoriesScreen/CategoriesScreen.dart';
import 'package:modules.news_app/modules/shop_app/FavoritesScreen/FavoritesScreen.dart';
import 'package:modules.news_app/modules/shop_app/ProductsScreen/ProductsScreen.dart';
import 'package:modules.news_app/modules/shop_app/SettingsScreen/SettingsScreen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void currentIndexChange(int index) {
    currentIndex = index;

    emit(ShopAppChangeCurrentIndexState());
  }

  List screensList =const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
}
