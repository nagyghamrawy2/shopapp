import 'package:conditional_builder_null_safety/example/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_layout_cubit.dart';
import 'package:shopapp/layout/shop_layout.dart';
import 'package:shopapp/modules/login/shop_login_screen.dart';
import 'package:shopapp/shared/Network/local/cache_helper.dart';
import 'package:shopapp/shared/bloc_observer.dart';
import 'package:shopapp/shared/component/constants.dart';
import 'package:shopapp/shared/cubit/app_cubit.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/styles/themes.dart';


void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  // bool? isDark = CacheHelper.getDate(key: 'isDark');
  token = CacheHelper.getData(key: 'token');

  if (token != null)
    widget = ShopLayout();
  else
    widget = ShopLoginScreen();
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
        ),
        BlocProvider(
          create: (BuildContext context) => ShopLayoutCubit()..getHomeData()..getCategories()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
