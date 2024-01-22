import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dioClient = Dio(BaseOptions(
  baseUrl: "https://stuverse.shop/api",
))
  ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');

    if (token != null) options.headers['Authorization'] = 'Token $token';

    return handler.next(options);
  }));
