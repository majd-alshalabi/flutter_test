class OrderProductParamsModel {
  final int productId;

  OrderProductParamsModel({
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;

    return data;
  }
}

class OrderProductsResponseModel {
  bool? success;
  String? message;

  OrderProductsResponseModel({this.success, this.message});

  OrderProductsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['status'];
    message = json['message'];
  }
}
