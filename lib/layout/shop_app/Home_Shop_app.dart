import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopCubit.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopStates.dart';

class HomeShopApp extends StatelessWidget {
  const HomeShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(builder:(context, state) {
      var get = ShopCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: const Text("Salla", style: TextStyle(color: Colors.teal)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: get.currentIndexChange,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.apps,
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: get.currentIndex,

        ),
        body: get.screensList[get.currentIndex],
      );
    }, listener: (context, state) {

    });
  }
}
