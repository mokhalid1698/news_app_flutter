import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopCubit.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopStates.dart';
import 'package:modules.news_app/models/categoriesModel/ModelCategories.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          var get = ShopCubit.get(context);
          return BuildCondition(
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildCategoriesUi(get.modelCategories!.data!.data[index]),
                separatorBuilder: (context, index) => Divider(),
                itemCount: get.modelCategories!.data!.data.length),
            condition: get.modelCategories != null,
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state) {});
    // return ListView.separated(
    //     itemBuilder: (context, index) => buildCategoriesUi(),
    //     separatorBuilder: (context, index) => Divider(),
    //     itemCount: 10);
  }

  Widget buildCategoriesUi( ModelCategoriesDataInData categoriesDataInData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 300.0,
            width: 400.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image:  DecorationImage(
                image: NetworkImage(
                    "${categoriesDataInData.image}"
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            // height: const .0,
            decoration: const BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14)),
            ),
            width: 400.0,

            child:  Text(
              "${categoriesDataInData.name}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40),
            ),
          ),
        ],
      ),
    );
  }
}

//
//

//
