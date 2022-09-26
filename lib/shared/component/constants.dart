import 'package:shopapp/modules/login/shop_login_screen.dart';
import 'package:shopapp/shared/Network/local/cache_helper.dart';
import 'package:shopapp/shared/component/components.dart';

String? token = "";

void signout(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if (value!) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)) );
}