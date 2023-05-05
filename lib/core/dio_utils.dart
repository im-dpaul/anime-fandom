import 'dart:developer';
import 'package:anime_fandom/core/hive_services.dart';
import 'package:dio/dio.dart';

class DioUtil {
  Dio? _instance;
  Dio? getInstance() {
    _instance ??= createDioInstance();
    return _instance;
  }

  Dio createDioInstance() {
    var dio = Dio();
    dio.interceptors.clear();
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final accessToken = HiveServices.getToken();
            // log("Token --> ${accessToken.toString()}");
            if (accessToken != null) {
              options.headers["Authorization"] = 'Bearer $accessToken';
            }
            options.headers['content-Type'] = 'application/json';
            return handler.next(options);
          },
          onResponse: (response, handler) {
            return handler.next(response);
          },
          onError: (DioError e, handler) async {
            log('dio error: $e');
            if (e.response != null) {
              handler.resolve(e.response!);
            }
          },
        ),
      );
  }
}
