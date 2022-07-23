class LoginModel {
  bool? status;
  String? message;
  ModelDataLogin? data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? ModelDataLogin.fromJson(json["data"]) : null;
  }
}

class ModelDataLogin {
  int? id;
  String? name;
  String? email;
  String? token;

// ignore: non_constant_identifier_names
  ModelDataLogin.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    email = data["email"];
    token = data["token"];
  }
}

// Map mo = {
//   "status": true,
//   "message": "Login done successfully",
//   "data": {
//     "id": 16121,
//     "name": "mohamed Al hamad",
//     "email": "mokhaid@gmali.com",
//     "phone": 12314567811,
//     "image":
//         "https: //student.valuxapps.com/storage/uploads/users/bNtvcl37K3_1657210017.jpeg",
//     "points": 0,
//     "credit": 0,
//     "token":
//         "RHKYWFniYw6uSILmCEOa1QMH7YCu9nytzHXxUhbxwL9Htu8R197VMJjJBD41pFMBB3ipBF",
//   }
// };
