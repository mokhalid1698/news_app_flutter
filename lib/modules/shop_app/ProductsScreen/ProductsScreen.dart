import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopCubit.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopStates.dart';
import 'package:modules.news_app/models/categoriesModel/ModelCategories.dart';

import '../../../models/home_shop_app_model/HomeDataModel.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          var get = ShopCubit.get(context);

          return BuildCondition(
            condition: get.modelDataHome != null && get.modelCategories != null,
            builder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Categories",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 180,
                          // color: Colors.black45,
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var data =
                                    get.modelCategories!.data!.data[index];
                                return BiuldFormCategories(data);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 50.0,
                                  ),
                              itemCount:
                                  get.modelCategories!.data!.data.length),
                        ),
                        if(get.modelDataHome!.data!.banners.length != null)
                        CarouselSlider(
                            items: get.modelDataHome!.data!.banners
                                .map(
                                  (e) => Image(
                                    image: NetworkImage("${e.image}"),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                              height: 200,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration: Duration(seconds: 1),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              scrollDirection: Axis.horizontal,
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("Home",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                        const SizedBox(
                          height: 15,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 1.0,
                          crossAxisSpacing: 3.0,
                          childAspectRatio: 1 / 1.6,
                          children: List.generate(
                              get.modelDataHome!.data!.products.length,
                              (index) {
                            var data = get.modelDataHome!.data!.products[index];

                            return BiuldFormHomeData(
                                get.modelDataHome!.data!.products[index],
                                context);
                          }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state) {});
  }

  // ignore: non_constant_identifier_names
  Widget BiuldFormCategories(ModelCategoriesDataInData data) => SizedBox(
        height: 100,
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage("${data.image}"),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              "${data.name}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      );

  // ignore: non_constant_identifier_names
  Widget BiuldFormHomeData(ModelDataHomeProducts data, context) {
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
              image: NetworkImage("${data.image}"),
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
                child: Text("${data.name}",
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
                    cubit.getDataChangeFavorites(data.id!);
                  },
                  icon: cubit.isFavorite![data.id] ?? false
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
              Text("${data.price}", style: const TextStyle(fontSize: 15)),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${data.oldPrice}",
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

// https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg
