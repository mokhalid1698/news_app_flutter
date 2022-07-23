class HomeModel {
  bool? status;
  ModelDataHome? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = ModelDataHome.fromJson(json["data"]);
  }
}

class ModelDataHome {
  List<ModelDataHomeBanners> banners = [];
  List<ModelDataHomeProducts> products = [];
  // String? ad;


  ModelDataHome.fromJson(Map<String, dynamic> json) {
    json["banners"].forEach((element) {
      banners.add(ModelDataHomeBanners.fromJson(element));
    });
    json["products"].forEach((element) {
      products.add(ModelDataHomeProducts.fromJson(element));
    });
    // ad = json["ad"];

  }
}

class ModelDataHomeBanners {
  int? id;
  String? image;
  // String? category;
  // String? product;

  ModelDataHomeBanners.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    // category = json["category"];
    // product = json["product"];
  }
}

class ModelDataHomeProducts {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ModelDataHomeProducts.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    price = json["price"];
    image = json["image"];
    name = json["name"];
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
  }
// {
// "id": 92,
// "price": 225,
// "old_price": 475,
// "discount": 53,
// "image": "https://student.valuxapps.com/storage/uploads/products/1644375298PFm8i.14.jpg",
// "name": "قميص بأكمام طويلة وجيب برقعة - زيتوني غامق",
// "description": "- يرتدي موديل مقاس L \r\n- مادة القطن\r\n- تناسب منتظم\r\n- اكمام طويلة",
// "images": [
// "https://student.valuxapps.com/storage/uploads/products/1644375298DjMDB.14.jpg",
// "https://student.valuxapps.com/storage/uploads/products/1644375298UaXrd.15.jpg",
// "https://student.valuxapps.com/storage/uploads/products/1644375298xsuvT.16.jpg",
// "https://student.valuxapps.com/storage/uploads/products/1644375298yVWz5.17.jpg"
// ],
// "in_favorites": false,
// "in_cart": false
// },
}

/*
*
*
*
*
*
*   "status": true,
    "message": null,
    "data": {
        "banners": [
            {
                "id": 11,
                "image": "https://student.valuxapps.com/storage/uploads/banners/1619472351ITAM5.3bb51c97376281.5ec3ca8c1e8c5.jpg",
                "category": null,
                "product": null
            },


        ],
        "products": [
           {
                "id": 92,
                "price": 225,
                "old_price": 475,
                "discount": 53,
                "image": "https://student.valuxapps.com/storage/uploads/products/1644375298PFm8i.14.jpg",
                "name": "قميص بأكمام طويلة وجيب برقعة - زيتوني غامق",
                "description": "- يرتدي موديل مقاس L \r\n- مادة القطن\r\n- تناسب منتظم\r\n- اكمام طويلة",
                "images": [
                    "https://student.valuxapps.com/storage/uploads/products/1644375298DjMDB.14.jpg",
                    "https://student.valuxapps.com/storage/uploads/products/1644375298UaXrd.15.jpg",
                    "https://student.valuxapps.com/storage/uploads/products/1644375298xsuvT.16.jpg",
                    "https://student.valuxapps.com/storage/uploads/products/1644375298yVWz5.17.jpg"
                ],
                "in_favorites": false,
                "in_cart": false
            },

        ],
        "ad": "https://student.valuxapps.com/storage/uploads/banners/1641000123OrbOP.BALCK-White-FRIDAY-AR21112019.jpg"
    }
}
*
*
*
*
*       */
