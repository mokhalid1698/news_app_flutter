import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopCubit.dart';
import 'package:modules.news_app/layout/shop_app/Home_Shop_app.dart';
import 'package:modules.news_app/modules/shop_app/loginScreen/loginScreen.dart';
import 'package:modules.news_app/shared/NetWork/end_points.dart';
import 'package:modules.news_app/shared/local/Shared_Preferences.dart';
import 'package:modules.news_app/shared/styles/themes.dart';

import 'bloc_observer.dart';

import 'layout/NewsApp/Cubit/cubit.dart';
import 'layout/NewsApp/Cubit/state.dart';
import 'shared/NetWork/dio_helpper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(() async {
    Widget? widget;
    DioHelper.init();
    await CacheHelper.init();
    token = await CacheHelper.getData(key: "token") ?? "";
    if (kDebugMode) {
      print(token.toString());
    }

    // ignore: unnecessary_null_comparison
    if (token.isNotEmpty) {
      widget = const HomeShopApp();
    } else {
      widget = LoginScreen();
    }
    runApp(MyApp2(startWidget: widget));
  }, blocObserver: MyBlocObserver());
}

//test mohamed khalid git
class MyApp2 extends StatelessWidget {
  final Widget startWidget;

  const MyApp2({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewsCubit()..getModeOfSharedPreferences(),
          ),
          BlocProvider(
            create: (context) => ShopCubit()..getDataHome(),
          )
        ],
        child: BlocConsumer<NewsCubit, NewsStates>(
            builder: (context, state) {
              var get = NewsCubit.get(context);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: get.mode ? ThemeMode.dark : ThemeMode.light,
                theme: lightTheme,
                darkTheme: darkTheme,
                home: startWidget,
                // home: const Directionality(textDirection: TextDirection.rtl, child: HomeNews()),
              );
            },
            listener: (_, l) {}));
  }
}

// git up mo hamed
