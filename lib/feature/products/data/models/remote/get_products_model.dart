class GetProductsResponseModel {
  List<ProductsModel>? data;
  bool? success;
  String? message;

  GetProductsResponseModel({this.data, this.success, this.message});

  GetProductsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductsModel>[];
      json['data'].forEach((v) {
        data!.add(ProductsModel.fromJson(v));
      });
    }
    success = json['status'];
    message = json['message'];
  }
}

class ProductsModel {
  int? id;
  String? title;
  String? description;
  String? image;
  int? comments;
  double? rate;
  String? createdAt;
  String? updatedAt;

  ProductsModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.comments,
    this.rate,
    this.createdAt,
    this.updatedAt,
  });

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    comments = json['comments'];
    if (json['rate'] != null) {
      rate = json['rate'].toDouble();
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['comments'] = comments;
    data['rate'] = rate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
