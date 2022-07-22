




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/layout/NewsApp/Cubit/cubit.dart';
import 'package:modules.news_app/layout/NewsApp/Cubit/state.dart';

import '../../modules/NewsApp/search_screen.dart';

class HomeNews extends StatelessWidget {
  const HomeNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var get = NewsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        get.ChangeModeIsDark();
                      },
                      icon: Icon(get.mode
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchScreen()));
                      },
                      icon: const Icon(Icons.search)),
                ),
              ],

              title: Text(get.mode ? "App News" : "App News Dark",
                  style: Theme.of(context).textTheme.bodyText1),
              // centerTitle: true,
            ),
            bottomNavigationBar: BottomNavigationBar(
                onTap: (value) => get.currentIndexRel(value),
                currentIndex: get.currentIndex,
                items: get.items),
            body: get.ScreensList[get.currentIndex],
          );
        },
        listener: (_, l) {});
  }
}
