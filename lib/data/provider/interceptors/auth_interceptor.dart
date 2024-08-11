import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor({
    required this.dio,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Add your API key & other stuff to the headers.
    options.headers.addAll({
      "X-RapidAPI-Key": "YOUR_API_KEY"
    });
    options.headers
        .addAll({"X-RapidAPI-Host": "moviesminidatabase.p.rapidapi.com"});
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Refresh the token if the request results with status code of 401.
      return handler
          .resolve(await dio.fetch(err.requestOptions)); // Repeat the request.
    }

    return handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: err.response,
    ));
  }
}