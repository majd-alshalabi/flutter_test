import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/core/services/network/network_configrations.dart';
import 'package:test_flutter/core/services/network/network_interface.dart';
import 'package:test_flutter/feature/account/domain/use_cases/get_my_identity_use_case.dart';

class NetworkServices implements IRemoteDataSource {
  static Map<String, String> headers =
      Map<String, String>.from(NetworkConfigurations.BaseHeaders);

  static Future<Map<String, String>> initTokenAndHeaders() async {
    headers.clear();

    /// get token
    final res = await GetMyIdentityUseCase().call(NoParams());
    res.fold(
      (l) => null,
      (r) => headers.addAll({"Authorization": "Bearer ${r?.token}"}),
    );

    headers.addAll({
      "accept": "application/json",
      "Content-Type": "application/json",
    });
    return headers;
  }

  _returnResponse(
    Response response,
    RemoteDataBundle bundle,
  ) async {
    log(response.data);
    var responseJson = json.decode(response.data);
    switch (response.statusCode) {
      case 201:
      case 200:
        return responseJson;
      case 401:
        if (responseJson != null && responseJson["message"] != null) {
          throw Exception(responseJson["message"]);
        }
        throw Exception("network error");
      default:
        if (responseJson != null && responseJson["message"] != null) {
          throw Exception(responseJson["message"]);
        }
        throw Exception("network error");
    }
  }

  @override
  Future get(RemoteDataBundle remoteBundle) async {
    try {
      await initTokenAndHeaders();
      headers.addAll({
        "Content-Type": "application/json",
      });
      BaseOptions options = BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      );
      Dio dio = Dio(options);
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
      final Response response = await Dio().get(
        NetworkConfigurations.BaseUrl + remoteBundle.networkPath,
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
          contentType: Headers.formUrlEncodedContentType,
        ),
        queryParameters: remoteBundle.urlParams,
      );
      return _returnResponse(response, remoteBundle);
    } on DioException catch (e) {
      if (e.response == null) throw Exception("no internet connection");
      return _returnResponse(e.response!, remoteBundle);
    }
  }

  @override
  Future post(RemoteDataBundle remoteBundle) async {
    try {
      await initTokenAndHeaders();
      headers.addAll({
        "Content-Type": "application/json",
      });
      BaseOptions options = BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      );
      Dio dio = Dio(options);
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));

      final response = await dio.post(
        NetworkConfigurations.BaseUrl + remoteBundle.networkPath,
        data: remoteBundle.body,
        queryParameters: remoteBundle.urlParams,
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      return _returnResponse(response, remoteBundle);
    } on DioException catch (e) {
      if (e.response == null) throw Exception("no internet connection");
      return _returnResponse(e.response!, remoteBundle);
    }
  }

  @override
  Future delete(RemoteDataBundle remoteBundle) async {
    try {
      await initTokenAndHeaders();
      headers.addAll({
        "Content-Type": "application/json",
      });
      BaseOptions options = BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      );
      Dio dio = Dio(options);
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));

      final response = await dio.delete(
        NetworkConfigurations.BaseUrl + remoteBundle.networkPath,
        data: remoteBundle.body,
        queryParameters: remoteBundle.urlParams,
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      return _returnResponse(response, remoteBundle);
    } on DioException catch (e) {
      if (e.response == null) throw Exception("no internet connection");
      return _returnResponse(e.response!, remoteBundle);
    }
  }

  @override
  Future postFormData(RemoteDataBundle remoteBundle) async {
    try {
      await initTokenAndHeaders();

      headers.addAll({"Content-Type": "multipart/form-data"});
      var dio = Dio();
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
      final response = await dio.post(
        NetworkConfigurations.BaseUrl + remoteBundle.networkPath,
        data: remoteBundle.data,
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      headers.addAll({
        "Content-Type": "application/json",
      });

      return _returnResponse(response, remoteBundle);
    } on DioException catch (e) {
      if (e.response == null) throw Exception("no internet connection");
      _returnResponse(e.response!, remoteBundle);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }
}
