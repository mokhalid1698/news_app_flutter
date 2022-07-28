class ModelProfile {
  bool? status;

  ModelGetDataProfile? data;

  ModelProfile.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = ModelGetDataProfile.fromJson(json["data"]);
  }
}

class ModelGetDataProfile {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;

  ModelGetDataProfile.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    name = json["name"];
    image = json["image"];
    phone = json["phone"];
  }
}
Map mo = {
  "status": true,
  "message": null,
  "data": {
    "id": 16121,
    "name": "mohamed Al hamad",
    "email": "mokhaid@gmali.com",
    "phone": "12314567811",
    "image":
    "https://student.valuxapps.com/storage/uploads/users/bNtvcl37K3_1657210017.jpeg",
    "points": 0,
    "credit": 0,
    "token":
    "uEcyG8KjWHbg39rx7qMM5GeDB1edu2cGKzXsdDUuISqjbv92Qh7xpSWMXF5JR5sJNOYosY"
  }
};
class UpdateProfileModel{



}



