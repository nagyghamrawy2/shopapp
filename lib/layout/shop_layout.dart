import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_layout_cubit.dart';
import 'package:shopapp/modules/login/shop_login_screen.dart';
import 'package:shopapp/modules/search/search_screen.dart';
import 'package:shopapp/shared/component/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Salla'
            ),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
              }, icon: Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items:
          [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                label: "home",
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              label: "categories",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "favorites",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "settings",
            ),
            ]),
        );
      },
    );
  }
}
