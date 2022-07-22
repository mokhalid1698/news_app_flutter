import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:modules.news_app/layout/NewsApp/Cubit/state.dart';



import '../../layout/NewsApp/Cubit/cubit.dart';
import 'Business.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var get = NewsCubit.get(context).search;

          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    onChanged: (value) {
                      NewsCubit.get(context).getDataSearch(value);
                    },
                    decoration: const InputDecoration(
                      labelText: "Search",
                      prefixIcon: Icon(Icons.search),

                    ),
                 
                  ),
                ),
                Expanded(
                  child: Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          state is! NewsGetDataSearchLod,
                      fallbackBuilder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      widgetBuilder: (context) => ListView.builder(
                            itemBuilder: (context, index) =>
                                DataShowUi(context, get[index]),
                            itemCount: get.length,
                            physics: const BouncingScrollPhysics(),
                          )),
                )
              ],
            ),
          );
        },
        listener: (c, i) {});
  }
}
