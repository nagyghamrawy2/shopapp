class ShopLoginModel
{
  late bool status;
  String? message;
  UserData? data;
  ShopLoginModel.fromjson(Map<String , dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] !=null ? UserData.fromjson(json['data']): null;
  }
}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late var points;
  late var credit;
  late String token;

  // UserData({
  //   this.credit,
  //   this.email,
  //   this.id,
  //   this.image,
  //   this.name,
  //   this.phone,
  //   this.points,
  //   this.token,
  // });
//named_constructor
    UserData.fromjson(Map<String , dynamic> json){
      id = json['id'];
      name = json['name'];
      credit = json['credit'];
      email = json['email'];
      image = json['image'];
      phone = json['phone'];
      points = json['points'];
      token = json['token'];
  }
}
