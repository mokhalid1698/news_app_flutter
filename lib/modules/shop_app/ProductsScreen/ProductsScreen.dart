import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [




        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [


              const Text("Categories",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
              const SizedBox(height: 15,),
              SizedBox(
                height: 180,
                // color: Colors.black45,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => BiuldFormCategories(),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 50.0,
                        ),
                    itemCount: 10),
              ),



            ],
          ),
        ),





      ],
    );
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
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            )
          ],
        ),
  );
}

// https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg
