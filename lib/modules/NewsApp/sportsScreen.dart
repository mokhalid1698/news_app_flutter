import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';


import '../../layout/NewsApp/Cubit/cubit.dart';
import '../../layout/NewsApp/Cubit/state.dart';
import 'Business.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return BlocConsumer<NewsCubit, NewsStates>(
          builder: (context, state) {
            if (kDebugMode) {

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
