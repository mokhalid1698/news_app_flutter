import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news_app/Screens/Business.dart';

import '../Cubit/cubit.dart';
import '../Cubit/state.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return BlocConsumer<NewsCubit, NewsStates>(
          builder: (context, state) {
            if (kDebugMode) {
              print(NewsCubit().sports);
            }
            var get = NewsCubit.get(context).sports;
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
