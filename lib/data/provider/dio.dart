import 'package:app/shared/constants/enums.dart';
import 'package:app/shared/constants/values.dart';
import 'package:dio/dio.dart';

import 'package:get_storage/get_storage.dart';
import 'interceptors/auth_interceptor.dart';

class DioClient {
  static const String _baseUrl = api;

  DioClient() {
    addInterceptor(LogInterceptor());
  }

  final storage = GetStorage();

  final Dio dio = Dio(
    BaseOptions(baseUrl: _baseUrl),
  );

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(AuthInterceptor(dio: dio));
    dio.interceptors.add(interceptor);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // get token from storage
          final token = storage.read(StorageKeys.token.name);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          } else {}
          return handler.next(options);
        },
      ),
    );
  }
}
