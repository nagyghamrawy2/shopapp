class CategoriesModel
{
  late bool status;
  CategoriesDataModel? data;
  CategoriesModel.formjson(Map<String,dynamic> json){
    status = json['status'];
    data = CategoriesDataModel.formjson(json['data']);
  }
}

class CategoriesDataModel
{
     int? current_page;
    List<DataModel> data =[];
    CategoriesDataModel.formjson(Map<String,dynamic> json){
      current_page = json['current_page'];
      json['data'].forEach((element){
        data.add(DataModel.formjson(element));
      });

    }
}

class DataModel
{
  late int id;
  late String name;
  late String image;
  DataModel.formjson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}