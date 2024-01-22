import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thread_app/common/utils/api.client.dart';
import 'package:thread_app/common/models/thread.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getthreads() async {
    emit(HomeLoading());
    try {
      final resp = await dioClient.get("/threads/");
      final List<Thread> threadList = [];
      for (final thread in resp.data) {
        threadList.add(Thread.fromJson(thread));
      }
      emit(HomeSuccess(threadList.reversed.toList()));
    } catch (e) {
      print(e);
      emit(HomeError(e.toString()));
    }
  }
}
