class LoginParamsModel {
  final String email;
  final String password;

  LoginParamsModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;

    return data;
  }
}

class LoginResponseModel {
  LoginResponseData? modelData;
  int? status;
  String? message;

  LoginResponseModel({this.modelData, this.status, this.message});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      modelData = LoginResponseData.fromJson(json['data']);
    }
    status = json['status'];
    message = json['message'];
  }
}

class LoginResponseData {
  late String name;
  late String token;

  LoginResponseData({
    required this.name,
    required this.token,
  });

  LoginResponseData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    token = json['token'];
  }
}
