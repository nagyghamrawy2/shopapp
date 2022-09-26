import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_layout_cubit.dart';
import 'package:shopapp/models/shop_app/categories.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return BuildCatItem(model: ShopLayoutCubit.get(context).categoriesModel!.data!.data[index],);
            },
            separatorBuilder: (contex, index) {
              return Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              );
            },
            itemCount: ShopLayoutCubit.get(context).categoriesModel!.data!.data.length
        );
      },
    );
  }
}

class BuildCatItem extends StatelessWidget {
  DataModel? model;
  BuildCatItem({this.model});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
                model!.image),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20,),
          Text(
            model!.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
          )
        ],
      ),
    );
  }
}
