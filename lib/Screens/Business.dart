import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news_app/Cubit/cubit.dart';
import 'package:news_app/Cubit/state.dart';
import 'package:news_app/Screens/web_view_screen.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          print(NewsCubit().business);
          var get = NewsCubit.get(context).business;
          return Conditional.single(
       context: context,
            conditionBuilder:  (context)=> state is! NewsGetDataBusinessLod,
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

  // ignore: non_constant_identifier_names

}
// ignore: non_constant_identifier_names
DataShowUi(BuildContext context, get) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(url: get["url"]),));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: NetworkImage("${get["urlToImage"] ?? "https://icon-library.com/images/null-icon/null-icon-3.jpg" }",scale: 2), fit: BoxFit.fill)),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      get["title"],
                      style: Theme.of(context).textTheme.headline1,
                      maxLines: 2,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      // width: 250,
                      // height: 100,
                        child: Text("${ get["description"]}",
                          style: Theme.of(context).textTheme.bodyText2,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${get["publishedAt"]}",
                        style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).primaryColor),
                      ),
                      Text(
                        "${get["source"]["name"]}",
                        style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).primaryColor),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}