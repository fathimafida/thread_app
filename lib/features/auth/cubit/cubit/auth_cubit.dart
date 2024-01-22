import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:thread_app/common/models/user.dart';
import 'package:thread_app/common/utils/api.client.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  void loginUser({required String username, required String password}) async {
    emit(AuthLoading());
    try {
      final user = await dioClient
          .post("/login/", data: {'username': username, 'password': password});
      final sharedPrefernces = await SharedPreferences.getInstance();
      print(user.data['token']);
      await sharedPrefernces.setString('token', user.data['token']);
      emit(AuthSuccess(User.fromJson(user.data)));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        print("Error unauthorized thread: ${e.response?.data['detail']}");
        emit(AuthError(e.response?.data['detail']));
      }
      print("Error login thread: $e");
      emit(AuthError(e.toString()));
    }
  }

  void loadUser() async {
    emit(AuthLoading());
    try {
      final sharedPrefernces = await SharedPreferences.getInstance();
      final token = sharedPrefernces.getString('token');
      final resp = await dioClient.get("/profile/",
          options: Options(headers: {'Authorization': 'Token $token'}));
      resp.data['token'] = token;
      emit(AuthSuccess(User.fromJson(resp.data)));
    } catch (e) {
      print(e);
      emit(AuthInitial());
    }
  }

  void logOut() async {
    final sharedPrefernces = await SharedPreferences.getInstance();
    sharedPrefernces.remove('token');
  }
}
