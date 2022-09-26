class HomeModel
{
  late bool status;
  HomeDataModel? data;

  HomeModel.fromjson(Map<String,dynamic> json){
    status = json['status'];
    data = HomeDataModel.formjson(json['data']);
  }
}

class HomeDataModel
{
  List<BannerModel> banners =[];
  List<ProductModel> products = [];
  HomeDataModel.formjson(Map<String , dynamic> json){
     json['banners'].forEach((element){
       banners.add(BannerModel.fromjson(element));
     },
     );
         json['products'].forEach((element){
       products.add(ProductModel.fromjson(element));
     }
     );
  }
}

class BannerModel
{
  late int id;
  late String image;
  BannerModel.fromjson(Map<String , dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel
{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
 late bool inFavorites;
  late bool inCart;

  ProductModel.fromjson(Map<String , dynamic> json){
        id = json['id'];
        price = json['price'];
        oldPrice = json['old_price'];
        discount = json['discount'];
        image = json['image'];
        name = json['name'];
        inFavorites = json['in_favorites'];
        inCart = json['in_cart'];

  }
}