class GetCommentParamsModel {
  final int productId;

  GetCommentParamsModel({
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;

    return data;
  }
}

class GetCommentResponseModel {
  List<CommentModel>? data;
  bool? success;
  String? message;

  GetCommentResponseModel({this.data, this.success, this.message});

  GetCommentResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CommentModel>[];
      json['data'].forEach((v) {
        data!.add(CommentModel.fromJson(v));
      });
    }
    success = json['status'];
    message = json['message'];
  }
}

class CommentModel {
  int? id;
  String? content;
  String? createdAt;
  String? updatedAt;

  CommentModel({
    this.id,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
