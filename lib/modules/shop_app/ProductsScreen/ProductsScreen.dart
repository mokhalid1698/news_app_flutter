import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopCubit.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopStates.dart';
import 'package:modules.news_app/shared/NetWork/end_points.dart';

import '../../../shared/local/Shared_Preferences.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          var get = ShopCubit.get(context);
          if (state is ShopAppGetDataHomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     const Text("Categories",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 30)),
                  //     const SizedBox(
                  //       height: 15,
                  //     ),
                  //     SizedBox(
                  //       height: 180,
                  //       // color: Colors.black45,
                  //       child: ListView.separated(
                  //           shrinkWrap: true,
                  //           scrollDirection: Axis.horizontal,
                  //           physics: BouncingScrollPhysics(),
                  //           itemBuilder: (context, index) =>
                  //               BiuldFormCategories(),
                  //           separatorBuilder: (context, index) =>
                  //           const SizedBox(
                  //             width: 50.0,
                  //           ),
                  //           itemCount: 10),
                  //     ),
                  //   ],
                  // ),
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
                              itemBuilder: (context, index) =>
                                  BiuldFormCategories(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 50.0,
                                  ),
                              itemCount: 10),
                        ),
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
                          crossAxisSpacing: 1.0,
                          childAspectRatio: 1 / 1.7,
                          children: List.generate(
                              get.modelDataHome!.data!.products.length,
                              (index) {
                            var data = get.modelDataHome!.data!.products[index];
                            return BiuldFormHomeData(data);
                          }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
        listener: (context, state) {});
  }

  // ignore: non_constant_identifier_names
  Widget BiuldFormCategories() => SizedBox(
        height: 100,
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  "https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg"),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              "electrionic devices",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      );

  // ignore: non_constant_identifier_names
  Widget BiuldFormHomeData(data) => Column(
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
            height: 250,
            width: 200,
            child: Image(
              image: NetworkImage("${data.image}"),
              height: 150,
              width: 150,
              fit: BoxFit.contain,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text("${data.name}",
                    maxLines: 2,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark))
            ],
          ),
          Row(
            children: [
              Text("${data.price}", style: const TextStyle(fontSize: 15)),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${data.oldPrice}",
                style: TextStyle(
                    fontSize: 10, decoration: TextDecoration.lineThrough),
              ),
            ],
          )
        ],
      );
}

// https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg
