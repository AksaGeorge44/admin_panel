


import '../productmodel/productmodel.dart';




class OrderModel {
  OrderModel({
    required this.totalPrice,
    required this.orderId,
    required this.payment,
    required this.products,
    required this.status,
    required this.userId,
  });

  String payment;
  String status;

  List<ProductModel> products;
  double totalPrice;
  String orderId;
  String userId;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    return OrderModel(
        orderId: json["orderId"],
        products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
        totalPrice: json["totalPrice"],
        status: json["status"],
        payment: json["payment"],
        userId: json["userId"]);
  }



}






