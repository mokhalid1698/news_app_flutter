import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/layout/%D9%8Dshop_app/Home_Shop_app.dart';
import 'package:modules.news_app/shared/styles/themes.dart';


import 'bloc_observer.dart';

import 'NetWork/dio_helpper.dart';

import 'layout/NewsApp/Cubit/cubit.dart';
import 'layout/NewsApp/Cubit/state.dart';
import 'layout/NewsApp/Home_News.dart';


void main() {
  BlocOverrides.runZoned(() {
    runApp(BlocProvider(
        create: (context) => NewsCubit()
          ..getDataBusiness()
          ..getModeOfSharedPreferences(),
        child: const MyApp2()));
    DioHelper.init();
  }, blocObserver: MyBlocObserver());
  // BlocObserver = MyBlocObserver();
}
//test mohamed khalid git
class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var get = NewsCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: get.mode ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: const HomeShopApp(),
            // home: const Directionality(textDirection: TextDirection.rtl, child: HomeNews()),
          );
        },
        listener: (_, l) {});
  }
}


// git up mo hamed