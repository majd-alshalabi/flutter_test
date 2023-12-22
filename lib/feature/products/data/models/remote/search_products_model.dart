import 'package:test_flutter/feature/products/data/models/remote/get_products_model.dart';

class SearchProductParamsModel {
  final String? title;
  final double? rate;

  SearchProductParamsModel({
    required this.title,
    required this.rate,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['rate'] = rate;

    return data;
  }
}

class SearchProductsResponseModel {
  bool? success;
  List<ProductsModel>? data;
  String? message;

  SearchProductsResponseModel({this.success, this.message});

  SearchProductsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['status'];
    if (json['data'] != null) {
      data = <ProductsModel>[];
      json['data'].forEach((v) {
        data!.add(ProductsModel.fromJson(v));
      });
    }
    message = json['message'];
  }
}
