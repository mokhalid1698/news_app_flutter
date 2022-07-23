import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/layout/NewsApp/Cubit/state.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../modules/NewsApp/Business.dart';
import '../../../modules/NewsApp/sportsScreen.dart';
import '../../../modules/NewsApp/technology.dart';
import '../../../shared/NetWork/dio_helpper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  bool mode = false;
  ThemeMode? themeMode;

  // ignore: non_constant_identifier_names
  ChangeModeIsDark() async {
    mode = !mode;

    emit(NewsChangeModeTheme());
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool("Mode", mode);
    if (kDebugMode) {
      print(mode);
    }
  }

  getModeOfSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    mode = prefs.getBool("Mode") ?? false;

    emit(NewsGetModeOfSharedPreferences());
  }

  int counter = 0;

  // ignore: non_constant_identifier_names
  ThemeMode? ModeTheme;

  void incrementCounter() {
    counter++;

    // emit(NewsChangeCounter());
  }

  // ignore: non_constant_identifier_names
  List ScreensList = [
    const BusinessScreen(),
    SportsScreen(),
    const TechnologyScreen()
  ];

  // Start ChangeBottomNav

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business_center), label: "Business"),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.wifi_protected_setup), label: "technology"),
  ];
  int currentIndex = 0;

  currentIndexRel(int v) {
    currentIndex = v;
    if (v == 1) {
      getDataSports();
    }
    if (v == 2) {
      getDataTechnology();
    }

    if (kDebugMode) {
      print(v);
    }
    emit(NewsChangeCurrentIndex());
  }

// End ChangeBottomNav

// GetData To List

  List<dynamic> business = [];

  void getDataBusiness() {
    emit(NewsGetDataBusinessLod());
    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": "eg",
      "category": "business",
      "apiKey": "0e78f0c4eaaa4d528b059cad83243fc1",
    }).then((value) {
      business = value.data["articles"];

      emit(NewsGetDataBusinessDone());
      if (kDebugMode) {}
    }).catchError((e) {
      if (kDebugMode) {
        print("Error" "  " "$e");
      }
    });
  }

  List<dynamic> sports = [];

  void getDataSports() {
    emit(NewsGetDataSportsLod());
    if (sports.isEmpty) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "sports",
        "apiKey": "0e78f0c4eaaa4d528b059cad83243fc1",
      }).then((value) {
        sports = value.data["articles"];

        emit(NewsGetDataSportDone());
        if (kDebugMode) {}
      }).catchError((e) {
        if (kDebugMode) {
          // print(e);
          print("Error" "  " "$e");
        }
      });
    }
  }

  List<dynamic> technology = [];

  void getDataTechnology() {
    emit(NewsGetDataTechnologyLod());
    if (technology.isEmpty) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "technology",
        "apiKey": "0e78f0c4eaaa4d528b059cad83243fc1",
      }).then((value) {
        technology = value.data["articles"];

        emit(NewsGetDataTechnologyDone());
        if (kDebugMode) {}
      }).catchError((e) {
        if (kDebugMode) {
          print("Error" "  " "$e");
        }
      });
    }
  }

  List<dynamic> search = [];

  void getDataSearch(String data) {
    search.clear();
    emit(NewsGetDataSearchLod());
    if (data.isNotEmpty) {
      if (search.isEmpty) {
        // https://newsapi.org/v2/everything?q=mohamed&apiKey=0e78f0c4eaaa4d528b059cad83243fc1

        DioHelper.getData(url: "v2/everything", query: {
          "q": data,
          "apiKey": "0e78f0c4eaaa4d528b059cad83243fc1",
        }).then((value) {
          search = value.data["articles"];

          emit(NewsGetDataSearchDone());
          if (kDebugMode) {
            print("search");
            // print(search);
          }
        }).catchError((e) {
          if (kDebugMode) {
            print("Error" "  " "$e");
          }
        });
      }
    }
  }
}
