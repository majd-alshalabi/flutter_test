import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_flutter/feature/account/data/models/local/my_identity_model.dart';

class AppSettings {
  static final AppSettings _instance = AppSettings._internal();

  factory AppSettings() {
    return _instance;
  }
  AppSettings._internal();

  MyIdentity? identity;

  /// this stream will is used to update the product data in the app
  StreamController<ProductUpdateModel> productUpdateStream =
      StreamController<ProductUpdateModel>.broadcast();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

abstract class ProductUpdateModel {}

class AddNewComment extends ProductUpdateModel {
  final int productId;

  AddNewComment({
    required this.productId,
  });
}
