import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

BaseOptions _baseOptions([String? baseUrl]) {
  final opts = BaseOptions(
    connectTimeout: const Duration(seconds: 60),
    validateStatus: (int? status) =>
        status! >= HttpStatus.ok && status < HttpStatus.multipleChoices ||
        status == HttpStatus.unauthorized ||
        status == HttpStatus.unprocessableEntity ||
        status == HttpStatus.notFound,
  );
  if (baseUrl != null) {
    opts.baseUrl = baseUrl;
  }
  return opts;
}

class AuthInterceptor extends Interceptor {
  final Dio dio;
  // final StorageDataService _storageDataService = locator<StorageDataService>();

  AuthInterceptor({
    required this.dio,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // final authToken =
    //     _storageDataService.getToken(kEncryptedAuthorizationTokenKey);
    // if (authToken.isNotEmpty) {
    //   options.headers['authorization'] = "Bearer $authToken";
    // }
    super.onRequest(options, handler);
  }
}

class ApiService {
  late final Dio _dio;

  ApiService() {
    try {
      _dio = Dio(_baseOptions());
      _dio.interceptors.add(AuthInterceptor(dio: _dio));
      (_dio.transformer as BackgroundTransformer).jsonDecodeCallback =
          _parseJson;
    } catch (e) {
      // print(e);
    }
  }

  Dio get dio => _dio;
}

dynamic _parseJson(String text) {
  return compute(_parseAndDecode, text);
}

dynamic _parseAndDecode(String response) {
  try {
    return jsonDecode(response);
  } catch (e) {
    return null;
  }
}
