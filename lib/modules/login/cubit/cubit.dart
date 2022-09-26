import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_app/login_model.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginLoadingState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = false;
  late ShopLoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value){
      print(value.data);
      loginModel = ShopLoginModel.fromjson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  void changePasswordVisibality(){
    isPassword = !isPassword;
    emit(ShopLoginPasswordVisibilityState());
  }
}
