class RegisterParamsModel {
  final String name;
  final String password;
  final String email;
  final String cPassword;

  RegisterParamsModel({
    required this.name,
    required this.cPassword,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['c_password'] = cPassword;
    return data;
  }
}

class RegisterResponseModel {
  RegisterResponseData? modelData;
  bool? success;
  String? message;

  RegisterResponseModel({this.modelData, this.success, this.message});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      modelData = RegisterResponseData.fromJson(json['data']);
    }
    success = json['status'];
    message = json['message'];
  }
}

class RegisterResponseData {
  late String name;
  late String token;

  RegisterResponseData({
    required this.name,
    required this.token,
  });

  RegisterResponseData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    token = json['token'];
  }
}
