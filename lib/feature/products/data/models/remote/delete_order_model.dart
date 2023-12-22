class DeleteOrderParamsModel {
  final int orderId;

  DeleteOrderParamsModel({
    required this.orderId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = orderId;

    return data;
  }
}

class DeleteOrderResponseModel {
  bool? success;
  String? message;

  DeleteOrderResponseModel({this.success, this.message});

  DeleteOrderResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['status'];
    message = json['message'];
  }
}
