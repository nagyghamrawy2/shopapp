part of 'shop_layout_cubit.dart';

@immutable
abstract class ShopLayoutStates {}

class ShopLayoutInitialState extends ShopLayoutStates {}

class ShopChangeBottomNavState extends ShopLayoutStates {}

class ShopLoadingHomeDataState extends ShopLayoutStates {}

class ShopSuccessHomeDataState extends ShopLayoutStates {}

class ShopErrorHomeDataState extends ShopLayoutStates {}

class ShopSuccessCategoriesState extends ShopLayoutStates {}

class ShopErrorCategoriesState extends ShopLayoutStates {}

class ShopLoadingUserDataState extends ShopLayoutStates {}

class ShopSuccessUserDataState extends ShopLayoutStates
{
  final ShopLoginModel loginmodel;

  ShopSuccessUserDataState(this.loginmodel);
}

class ShopErrorUserDataState extends ShopLayoutStates {}