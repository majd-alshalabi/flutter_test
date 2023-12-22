class RateProductParamsModel {
  final int productId;
  final double rate;

  RateProductParamsModel({
    required this.rate,
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['product_id'] = productId;

    return data;
  }
}

class RateProductsResponseModel {
  bool? success;
  String? message;

  RateProductsResponseModel({this.success, this.message});

  RateProductsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['status'];
    message = json['message'];
  }
}
