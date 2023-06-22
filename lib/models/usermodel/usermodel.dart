import 'dart:convert';


UserModel userModelFromJson(String str)=>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data)=>json.encode(data.toJson());

class UserModel{
  UserModel (
      {

        required this.id,
        required this.name,
        required this.image,
        required this.email,
         this.notificationToken,
      }
      );
  String? image;
  String id;
  String name;
  String email;
  String? notificationToken;

  factory UserModel.fromJson(Map<String,dynamic>json)=>UserModel(
    id:json["id"],
    name:json["name"],
    image:json["image"],
    email:json["email"],
    notificationToken: json["notificationToken"],

  );

  Map<String,dynamic> toJson()=> {
    "id":id,
    "name":name,
    "image":image,
    "email":email,
    "notificationToken":notificationToken

  };
  UserModel copyWith({
    String?name,image,
  })=>

      UserModel(
        id: id,
        name: name??this.name,
        image: image??this.image,
        email: email,

      );

}