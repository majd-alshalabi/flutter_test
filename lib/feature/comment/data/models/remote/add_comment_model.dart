class AddCommentParamsModel {
  final String content;
  final int productId;
  AddCommentParamsModel({
    required this.productId,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['content'] = content;

    return data;
  }
}

class AddCommentResponseModel {
  bool? success;
  String? message;

  AddCommentResponseModel({this.success, this.message});

  AddCommentResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['status'];
    message = json['message'];
  }
}
