class ModelCategories {
  bool? status;
  ModelCategoriesData? data;

  ModelCategories.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data =  json["data"] != null ? ModelCategoriesData.fromJson1(json["data"]) : null;
  }
}

class ModelCategoriesData {
  int? total;
  List<ModelCategoriesDataInData> data = [];

  ModelCategoriesData.fromJson1(Map<String, dynamic> json) {
    total = json["total"];
    json["data"].forEach((v) {
      data.add(ModelCategoriesDataInData.fromJson2(v));
    });

  }
}

class ModelCategoriesDataInData {
  int? id;
  String? name;
  String? image;
  ModelCategoriesDataInData.fromJson2(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];


  }
}

// {
// "status": true,
// "message": null,
// "data": {
// "current_page": 1,
// "data": [
// {
// "id": 44,
// "name": "اجهزه الكترونيه",
// "image": "https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg"
// },
//
// ],
//
// "total": 5
// }
// }
