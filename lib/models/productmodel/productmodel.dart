import 'dart:convert';

ProductModel productModelFromJson(String str)=>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data)=>json.encode(data.toJson());

class ProductModel{
  ProductModel (
  {

 required this.id,
  required this.name,
    required this.description,
    required this.categoryId,
    required this.image,
    required this.isFavourite,
    required this.price,
    required this.status,
    this.qty,
  }
);
  String image;
  String id;
      String categoryId;
  bool isFavourite;
  String name;
  double price;
  String description;
  String status;
  int?qty;

  factory ProductModel.fromJson(Map<String,dynamic>json)=>ProductModel(
    id:json["id"],
    name:json["name"],
    description:json["description"],
    categoryId:json["categoryId"]??"",
    image:json["image"],
    isFavourite:false,
    qty:json["qty"],
    price: double.parse(json["price"].toString()),
    status:json["status"],

);

  Map<String,dynamic> toJson()=> {
    "id":id,
    "name":name,
    "image":image,
    "description":description,
    "categoryId":categoryId,
    "isFavourite":isFavourite,
    "price":price,
    "status":status,
    "qty":qty,

};
  ProductModel copyWith({
    String? name,
    String? image,
    String? id,
    String? categoryId,
    String? description,
    String? price,
  })=>

      ProductModel(
        id: id??this.id,
        name: name??this.name,
        categoryId: categoryId ?? this.categoryId,
        description: description??this.description,
        isFavourite: false,
        price: price!=null?double.parse(price): this.price,
        image: image??this.image, status: status,
        qty: 1,


      );

}