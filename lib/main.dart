import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Cubit/cubit.dart';
import 'package:news_app/Cubit/state.dart';
import 'package:news_app/NetWork/dio_helpper.dart';
import 'package:news_app/Screens/Home_News.dart';
import 'Cubit/bloc_observer.dart';

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
            theme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                  border: const OutlineInputBorder(),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  )),
              primarySwatch: Colors.teal,
              appBarTheme: const AppBarTheme(
                  color: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black),
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark)),
              textTheme: const TextTheme(
                  bodyText2: TextStyle(
                    fontSize: 10, overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    // fontSize: 40,
                    // fontWeight: FontWeight.bold,
                  ),
                  bodyText1:
                      TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis
                          // color: Colors.white,
                          // fontSize: 40,
                          // fontWeight: FontWeight.bold,
                          ),
                  headline1: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black26,
              primarySwatch: Colors.teal,
              disabledColor: Colors.white60,
              inputDecorationTheme: InputDecorationTheme(
                  border: const OutlineInputBorder(),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  )),
              appBarTheme: const AppBarTheme(
                  color: Colors.black,
                  iconTheme: IconThemeData(color: Colors.white),
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                      statusBarIconBrightness: Brightness.light)),
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 16, overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    // fontSize: 40,
                    // fontWeight: FontWeight.bold,
                  ),
                  bodyText2: TextStyle(
                    fontSize: 10, overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    // fontSize: 40,
                    // fontWeight: FontWeight.bold,
                  ),
                  headline1: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            home: const Directionality(
                textDirection: TextDirection.rtl, child: HomeNews()),
          );
        },
        listener: (_, l) {});
  }
}
