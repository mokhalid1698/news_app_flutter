class ModelFavorites {
bool? status;
String? message;

ModelFavorites.fromJson(Map<String,dynamic>json){
  status = json["status"];
  message = json["message"];
}
  // "status": true,
  // "message": "تمت الإضافة بنجاح",
}