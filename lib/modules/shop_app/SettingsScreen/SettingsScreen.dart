import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopCubit.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopStates.dart';
import 'package:modules.news_app/shared/defaultFormField.dart';

import '../../../shared/local/Shared_Preferences.dart';
import '../loginScreen/loginScreen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final controllerEmail = TextEditingController();
  final controllerName = TextEditingController();
  final controllerPhone = TextEditingController();

  // final controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var getData = ShopCubit.get(context);
        controllerEmail.text = getData.modelProfile!.data!.email!;
        controllerName.text = getData.modelProfile!.data!.name!;
        controllerPhone.text = getData.modelProfile!.data!.phone!;

        return BuildCondition(
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          condition: getData.modelProfile != null,
          builder: (context) => Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(140),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 10,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 120,
                      backgroundImage: NetworkImage(
                          "https://scontent.fcai19-4.fna.fbcdn.net/v/t1.6435-9/79644583_564258130973396_1604634236013248512_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=E3pCrZisvEIAX_PL7tN&tn=MDniMcAV3Db9bOQl&_nc_ht=scontent.fcai19-4.fna&oh=00_AT9bkBYgsh0Z6For-6J1n6GEJMfhCtrlr0aGCTr90P8C6Q&oe=63076E9D"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${getData.modelProfile!.data!.name}",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(getData.modelProfile!.data!.email.toString()),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 120,
                    child: defaultButton(
                        background: Theme.of(context).primaryColor,
                        function: () {
                          getData.showEdit();
                        },
                        text: "edit profile"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 120,
                    child: defaultButton(
                        background: Theme.of(context).primaryColor,
                        function: () async {
                          await CacheHelper.logout(key: "token").then((value) {
                            getData.logout().then((value){


                              navigateAndFinish(context, LoginScreen());
                            });

                          });
                          ;
                        },
                        text: "Logout"),
                  ),
                  if (getData.Lod) editDate(context, getData, state)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  buildSingleChildScrollView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: controllerName,
            keyboardType: TextInputType.name,
            enabled: true,
            decoration: const InputDecoration(
              suffixIcon: null,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: controllerEmail,
            keyboardType: TextInputType.emailAddress,
            enabled: true,
            decoration: const InputDecoration(
              suffixIcon: null,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: controllerPhone,
            keyboardType: TextInputType.phone,
            enabled: true,
            decoration: const InputDecoration(
              suffixIcon: null,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget editDate(BuildContext context, ShopCubit getData, ShopStates state) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextFormField(
            controller: controllerName,
            keyboardType: TextInputType.name,
            enabled: true,
            decoration: const InputDecoration(
              suffixIcon: null,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: controllerEmail,
            keyboardType: TextInputType.emailAddress,
            enabled: true,
            decoration: const InputDecoration(
              suffixIcon: null,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: controllerPhone,
            keyboardType: TextInputType.phone,
            enabled: true,
            decoration: const InputDecoration(
              suffixIcon: null,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          defaultButton(
              background: Theme.of(context).primaryColor,
              function: () {
                getData.putDataProfile(
                  name: controllerName.text,
                  email: controllerEmail.text,
                  phone: controllerPhone.text,
                );
              },
              text: "Edit"),
          if (state is ShopAppPutDataProfileLoadingState)
            const Center(child: LinearProgressIndicator())
        ],
      ),
    );
  }
}
