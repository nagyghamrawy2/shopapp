import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopapp/models/shop_app/categories.dart';
import 'package:shopapp/models/shop_app/homemodel.dart';
import 'package:shopapp/models/shop_app/login_model.dart';
import 'package:shopapp/modules/categories/categories_screen.dart';
import 'package:shopapp/modules/favourite/favourite_screen.dart';
import 'package:shopapp/modules/product/products_screen.dart';
import 'package:shopapp/modules/settings/settings_screen.dart';
import 'package:shopapp/shared/component/constants.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

part 'shop_layout_state.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(ShopLayoutInitialState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME , token: token, ).then((value) {
      homeModel = HomeModel.fromjson(value.data);

      printFullText(homeModel!.data!.banners[0].image);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES , token: token, ).then((value) {
      categoriesModel = CategoriesModel.formjson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
    print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(url: PROFILE , token: token, ).then((value) {
      userModel = ShopLoginModel.fromjson(value.data);
        printFullText(userModel!.data!.name);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      printFullText(error.toString());
      emit(ShopErrorUserDataState());
    });
  }



}
