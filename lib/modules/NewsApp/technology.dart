import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:modules.news_app/layout/NewsApp/Cubit/cubit.dart';
import 'package:modules.news_app/layout/NewsApp/Cubit/state.dart';


import 'Business.dart';

class TechnologyScreen extends StatelessWidget {
  const TechnologyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          if (kDebugMode) {
            print(NewsCubit().technology);
          }
          var get = NewsCubit.get(context).technology;
          return Conditional.single(
              context: context,
              conditionBuilder:  (context)=> state is! NewsGetDataSportsLod,
              fallbackBuilder: (context)=> const Center(child: CircularProgressIndicator()),
              widgetBuilder: (context )=> ListView.builder(
                itemBuilder: (context, index) =>
                    DataShowUi(context, get[index]),
                itemCount: get.length,
                physics: const BouncingScrollPhysics(),
              )
          );
        },
        listener: (context, state) {});
  }
}
