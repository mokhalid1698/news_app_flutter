import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopCubit.dart';
import 'package:modules.news_app/models/favoritesModel/modelFavorites.dart';

import '../../../layout/shop_app/Cubit/ShopStates.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = ShopCubit.get(context);

       return BuildCondition(
         builder: (context) => GridView.count(
           shrinkWrap: true,
           // physics: const NeverScrollableScrollPhysics(),
           crossAxisCount: 2,
           mainAxisSpacing: 1.0,
           crossAxisSpacing: 3.0,
           childAspectRatio: 1 / 1.9,
           children: List.generate(
               get.modelGetFavorites!.data!.data!.length,
                   (index) {
                 // var data = get.modelDataHome!.data!.products[index];

                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: BiuldFormHomeData(
                       get.modelGetFavorites!.data!.data![index],
                       context),
                 );
               }),
         ),
         condition: get.modelGetFavorites != null,
         fallback: (context) => const Center(child: CircularProgressIndicator()),
       );

      },
    );
  }


  Widget BiuldFormHomeData(ModelGetFavoritesList data, context) {
    var cubit = ShopCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              // BoxShadow(
              //   color: Colors.grey.withOpacity(0.5),
              //   spreadRadius: 5,
              //   blurRadius: 7,
              //   offset: Offset(0, 3), // changes position of shadow
              // ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          height: 280,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image(
              image: NetworkImage("${data.product!.image}"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Text("${data.product!.name}",
                    maxLines: 2,
                    style: const TextStyle(
                      height: 1,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () async {
                    cubit.getDataChangeFavorites(data.product!.id!);
                  },
                  icon: cubit.isFavorite![data.product!.id] ?? false
                      ? const Icon(
                    Icons.bookmark,
                    color: Colors.teal,
                  )
                      : const Icon(
                    Icons.bookmark,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
        SizedBox(
          width: 200,
          child: Row(
            children: [
              Text("${data.product!.price}", style: const TextStyle(fontSize: 15)),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${data.product!.oldPrice}",
                style: const TextStyle(
                    fontSize: 10, decoration: TextDecoration.lineThrough),
              ),
            ],
          ),
        )
      ],
    );
  }
}
