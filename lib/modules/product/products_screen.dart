import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_layout_cubit.dart';
import 'package:shopapp/models/shop_app/categories.dart';
import 'package:shopapp/models/shop_app/homemodel.dart';
import 'package:shopapp/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopLayoutCubit.get(context).homeModel != null && ShopLayoutCubit.get(context).categoriesModel != null,
            builder: (context) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: ProductsBuilder(
                  model: ShopLayoutCubit.get(context).homeModel,
                  categoriesModel:ShopLayoutCubit.get(context).categoriesModel ,
                ),
              );
            },
            fallback: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            });
      },
    );
  }
}

class ProductsBuilder extends StatelessWidget {
  ProductsBuilder({this.model , this.categoriesModel});

  HomeModel? model;
  CategoriesModel? categoriesModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model!.data!.banners
              .map((e) => Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ))
              .toList(),
          options: CarouselOptions(
            height: 250,
            initialPage: 0,
            // hbd2 mn anhy w7da
            enableInfiniteScroll: true,
            // hyfdl ylf 7waleen nfso 3la tool
            reverse: false,
            // myt2lb4
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            // d hgmo f el4a4a
            viewportFraction: 1,
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Categories",
                style: TextStyle(fontSize: 24 , fontWeight: FontWeight.w800),

              ),
              SizedBox(height: 10,),
              Container(
                height: 120,

                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder:(context , index) {
                      return BuildCategoryItem(model: categoriesModel!.data!.data[index],);
                    } ,
                    separatorBuilder: (context , index) {
                      return SizedBox(width: 10.0,);
                    },
                    itemCount: categoriesModel!.data!.data.length,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "New Products",
                style: TextStyle(fontSize: 24 , fontWeight: FontWeight.w800),

              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount:2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1/1.55,
            children: List.generate(model!.data!.products.length,
                    (index) =>BuildGridProducts(model:model!.data!.products[index] ),
            ),
          ),
        ),
      ],
    );
  }
}
class BuildGridProducts extends StatelessWidget {
  ProductModel? model;
  BuildGridProducts({this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model!.image),
                width: double.infinity,
                height: 200.0,
              ),
              if(model!.discount !=0)
              Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.red,
                child: Text(
                  "DISCOUNT",
                  style: TextStyle(fontSize: 10 , color: Colors.white),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model!.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 18,
                      height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model!.price.round()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    if(model!.discount !=0)
                      Text(
                        '${model!.oldPrice.round()}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){}, icon: Icon(Icons.favorite_border) , iconSize: 12.0,)

                  ],
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}

class BuildCategoryItem extends StatelessWidget {
  DataModel? model;
  BuildCategoryItem({this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model!.image,),
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: double.infinity,
            child: Text(
              model!.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

