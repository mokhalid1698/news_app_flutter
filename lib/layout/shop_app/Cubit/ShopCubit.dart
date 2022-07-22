import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modules.news_app/layout/shop_app/Cubit/ShopStates.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(InitialState());

  static ShopCubit get(context)=> BlocProvider.of(context);



  int currentIndex = 0;


  void currentIndexChange(int index){

    currentIndex = index;

    emit(ShopAppChangeCurrentIndexState());
  }











}