class ModelFavorites {
  bool? status;
  String? message;

  ModelFavorites.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
// "status": true,
// "message": "تمت الإضافة بنجاح",
}

class ModelGetFavorites {
  bool? status;
  ModelGetFavoritesData? data;

  ModelGetFavorites.fromJson(Map<String, dynamic> json){
    status = json["status"];

    data = ModelGetFavoritesData.fromJson(json["data"]);
  }

}

class ModelGetFavoritesData {
  int? total;
  List<ModelGetFavoritesList>? data = [];

  ModelGetFavoritesData.fromJson(Map<String, dynamic> json){
    total = json["total"];
    json["data"].forEach((element) {
      data!.add(ModelGetFavoritesList.fromJson(element));
    });
  }
}

class ModelGetFavoritesList {
  int? id;
  ModelGetFavoritesProducts? product;

  ModelGetFavoritesList.fromJson(Map<String, dynamic> json){
    id = json["id"];
    product = ModelGetFavoritesProducts.fromJson(json["product"]);


  }



  }

class ModelGetFavoritesProducts {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;

  ModelGetFavoritesProducts.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    price = json["price"];
    image = json["image"];
    name = json["name"];
  }
}

Map mo = {
  "message": null,
  "data": {
    "data": [
      {
        "id": 79427,
        "product": {
          "id": 90,
          "price": 110,
          "old_price": 160,
          "discount": 31,
          "image":
          "https://student.valuxapps.com/storage/uploads/products/1644372386y0SzM.4.jpg",
          "name": "بلوفر شتوي بياقة عالية - جملي",
          "description":
          "نسعي لتقديم منتجات تجمع بين الموضة والحياة العملية حيث يتم تصنيع منتجاتنا من افضل الخامات والتقنيات المبتكرة في مجال الأقمشة والالوان والتصميمات"
        }
      },
    ],
    "total": 9
  }
};
